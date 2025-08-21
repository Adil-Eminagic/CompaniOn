using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.SignalRHubs
{
    public class MessageHub : Hub
    {
        public async Task SendMessage(string receiverUsername, object message)
        {
            await Clients.User(receiverUsername).SendAsync("ReceiveMessage", message);
        }
    }
}
