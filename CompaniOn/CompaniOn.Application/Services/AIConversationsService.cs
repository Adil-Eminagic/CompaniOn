using AutoMapper;
using FluentValidation;
using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Core.Entities;
using System.Text.Json;
using System.Threading.Tasks;
using Azure.AI.OpenAI;
using Azure.Identity;
using System;
using System.Collections.Generic;
using System.Threading;
using OpenAI.Chat;
using Azure;
using OpenAI;

namespace CompaniOn.Application
{
    public class AIConversationsService : BaseService<AIConversation, AIConversationDto, AIConversationUpsertDto, AIConversationSearchObject, IAIConversationsRepository>, IAIConversationsService
    {
        private readonly OpenAIClient _openAIClient;
        private readonly string _modelName;

        public AIConversationsService(
            IMapper mapper,
            IUnitOfWork unitOfWork,
            IValidator<AIConversationUpsertDto> validator)
            : base(mapper, unitOfWork, validator)
        {
            string apiKey = Environment.GetEnvironmentVariable("OPENAI_API_KEY");
            _openAIClient = new OpenAIClient(apiKey);
            _modelName = "gpt-4o";
        }

        public override async Task<AIConversationDto> AddAsync(AIConversationUpsertDto dto, CancellationToken cancellationToken = default)
        {
            var aiResponse = await GetAzureAIResponseAsync(dto.UserId, dto.Question, cancellationToken);
            dto.Response = aiResponse.Response;
            dto.SentimentAnalysis = aiResponse.SentimentAnalysis;
            return await base.AddAsync(dto, cancellationToken);
        }

        public async Task<(string Response, string SentimentAnalysis)> GetAzureAIResponseAsync(int id, string input, CancellationToken cancellationToken = default)
        {
            try
            {
                // Construct the conversation prompt  
                string customPrompt = @"  
               You are an AI assistant that is there to talk to elderly people and be a friend to them. Keep your answers a bit short.  
               Here is the question the user had: ";

                string combinedInput = customPrompt + input;

                var lastConvo = await CurrentRepository.GetLastEntry(id);

                if (lastConvo != null)
                {
                    combinedInput += $@"  
                   Here is the previous question the user asked: {lastConvo.Question}.  
                   Here is the response you gave: {lastConvo.Response}.  
                   Use this context to improve your response.";
                }

                // Correctly use the ChatClient from OpenAIClient  
                var chatClient = _openAIClient.GetChatClient(_modelName);

                List<ChatMessage> messages = new()
               {
                   ChatMessage.CreateSystemMessage(customPrompt),
                   ChatMessage.CreateUserMessage(combinedInput)
               };

                var chatResponse = await chatClient.CompleteChatAsync(messages);

                string response = chatResponse.Value.Content[0].Text.ToString();

                if (string.IsNullOrWhiteSpace(response))
                {
                    throw new Exception("Failed to parse AI response.");
                }

                // Sentiment analysis  
                string sentimentPrompt = @"  
               You are an AI that specializes in sentiment analysis.   
               Determine if the sentiment of the user's input is 'normal' or 'alarming'.  
               Sentiment is 'alarming' if the user mentions issues such as mental health problems, loneliness, feeling depressed, or making troublesome statements.  
               Otherwise, the sentiment is 'normal'.  
               Only output 'normal' or 'alarming'.  
               User input: ";

                List<ChatMessage> sentimentMessages = new()
               {
                   ChatMessage.CreateSystemMessage(sentimentPrompt),
                   ChatMessage.CreateUserMessage(input)
               };

                var sentimentResponse = await chatClient.CompleteChatAsync(sentimentMessages);

                Console.WriteLine("Sentiment Response: " + sentimentResponse.Value.Content[0].Text.ToLower().ToString());

                string sentiment = sentimentResponse.Value.Content[0].Text.ToLower().ToString();

                if (sentiment != "normal" && sentiment != "alarming")
                {
                    throw new Exception("Unexpected sentiment analysis result.");
                }

                if (sentiment != "normal" && sentiment != "alarming")
                {
                    throw new Exception("Unexpected sentiment analysis result.");
                }

                return (response, sentiment);
            }
            catch (Exception ex)
            {
                // Handle exceptions appropriately  
                throw new Exception($"Error while getting OpenAI response: {ex.Message}", ex);
            }
        }

        public async Task<AIConversationDto?> GetLastMemberAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await CurrentRepository.GetLastEntry(id, cancellationToken);
            return Mapper.Map<AIConversationDto>(entity);
        }
    }
}