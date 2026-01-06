import asyncio
from client_class import ChatClient


nickname = input('Enter your name for chat: ')
chat_client = ChatClient(nickname)

asyncio.run(chat_client.start())