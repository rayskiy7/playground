import asyncio
from server_class import ChatServer


chat_server = ChatServer()
asyncio.run(chat_server.start())