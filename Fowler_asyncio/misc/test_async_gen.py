import util
import asyncio


async def numbers(n):
    for i in range(n):
        await util.delay(i)
        yield i


async def main():
    g = numbers(10)
    print(await anext(g))
    print(await anext(g))
    print(await anext(g))
    print(await anext(g))


asyncio.run(main())
