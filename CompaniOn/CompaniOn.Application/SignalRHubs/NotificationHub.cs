using Microsoft.AspNetCore.SignalR;
using System.Collections.Concurrent;
using Microsoft.EntityFrameworkCore;
using CompaniOn.Infrastructure;
using CompaniOn.Core.Entities;
using System;

namespace CompaniOn.Application.SignalRHubs
{
    public class NotificationHub : Hub
    {
        private readonly DatabaseContext _context;
        private static readonly ConcurrentDictionary<string, string> UserConnections = new();

        public NotificationHub(DatabaseContext context)
        {
            _context = context;
        }

        public async Task RegisterUser(string userId)
        {
            UserConnections[Context.ConnectionId] = userId;
            await Clients.Client(Context.ConnectionId).SendAsync("UserRegistered", "User successfully registered with ID: " + userId);
        }

        
        public async Task NotifyFamilyMembers(int userId, string message)
        {
            
            var familyLinks = await _context.FamilyLinks
                .Where(fl => fl.UserId == userId)
                .Include(fl => fl.FamilyMember)
                .ToListAsync();

            List<Notification> notificationList = new List<Notification>();

            foreach (var familyLink in familyLinks)
            {
                var familyMemberId = familyLink.FamilyMemberId;

                var notification = new Notification()
                {
                    SenderId = userId,
                    ReceiverId = familyMemberId,
                    Title = $"SOS message",
                    Message = message,
                    IsRead = false,
                    IsDeleted = false,
                    CreatedAt = DateTime.Now,
                    ModifiedAt = null
                };

                notificationList.Add(notification);

                var connectionId = UserConnections.FirstOrDefault(x => x.Value == familyMemberId.ToString()).Key;

                if (!string.IsNullOrEmpty(connectionId))
                {
                    await Clients.Client(connectionId).SendAsync("ReceiveMessage", message);
                }
                else
                {
                    Console.WriteLine($"Family member {familyMemberId} is not online.");
                }
            }

            if(notificationList.Count > 0)
            {
                await _context.Notifications.AddRangeAsync(notificationList);
                await _context.SaveChangesAsync();
            }
        }

        //public async Task NotifyAboutFamilyMemberLocation(int basicUserId, string message) //for testing // for test
        //{
        //    var connectionId = UserConnections.FirstOrDefault(x => x.Value == basicUserId.ToString()).Key;

        //    if (!string.IsNullOrEmpty(connectionId))
        //    {
        //        await Clients.Client(connectionId).SendAsync("ReceiveLocation", message);
        //    }
        //    else
        //    {
        //        Console.WriteLine($"Basic user {basicUserId} is not online.");
        //    }

        //}

        public async Task NotifyAboutUserLocation(int basicUserId, string message) //real
        {
            var familyLink = _context.FamilyLinks.Where(f => f.UserId == basicUserId).FirstOrDefault();

            if (familyLink != null)
            {
                var FamilyMemberId = familyLink.FamilyMemberId;
                var connectionId = UserConnections.FirstOrDefault(x => x.Value == FamilyMemberId.ToString()).Key;

                var notification = new Notification()
                { 
                    SenderId= basicUserId, 
                    ReceiverId = FamilyMemberId,
                    Title = $"Location of {familyLink.Kinship}",
                    Message = message,
                    IsRead = false,
                    IsDeleted = false,
                    CreatedAt = DateTime.Now,
                    ModifiedAt = null
                };

                await _context.Notifications.AddAsync(notification);
                await _context.SaveChangesAsync();


                if (!string.IsNullOrEmpty(connectionId))
                {
                    await Clients.Client(connectionId).SendAsync("ReceiveLocation", message);
                }
                else
                {
                    Console.WriteLine($"Basic user {basicUserId} is not online.");
                }
            }
        }

        public async Task NotifyAboutNewMessages(int senderId, int recieverId)
        {
                var notification = new Notification()
                {
                    SenderId = senderId,
                    ReceiverId = recieverId,
                    Title = $"Message notification",
                    Message = "You have new messages!",
                    IsRead = false,
                    IsDeleted = false,
                    CreatedAt = DateTime.Now,
                    ModifiedAt = null
                };

                await _context.Notifications.AddAsync(notification);
                await _context.SaveChangesAsync();
            var connectionId = UserConnections.FirstOrDefault(x => x.Value == recieverId.ToString()).Key;

            if (!string.IsNullOrEmpty(connectionId))
            {
                await Clients.Client(connectionId).SendAsync("ReceiveLocation");
            }
            else
            {
                Console.WriteLine($"User {recieverId} is not online.");
            }

        }


        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            UserConnections.TryRemove(Context.ConnectionId, out _);
            await base.OnDisconnectedAsync(exception);
        }
    }
}
