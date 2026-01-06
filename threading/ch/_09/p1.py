import asyncio
import aiohttp
import asyncpg
from aiohttp import web


app = web.Application()
routes = web.RouteTableDef()


async def create_pool(app):
    app['pool'] = await asyncpg.create_pool(
        host='127.0.0.1',
        port=5432,
        user='postgres',
        database='products',
        password='password',
        min_size=6,
        max_size=10,
    )


async def clear_pool(app):
    print('close connection pool...')
    await app['pool'].close()
    print('connection pool is closed')


app.on_startup.append(create_pool)
app.on_cleanup.append(clear_pool)


@routes.get('/brands')
async def get_brands(request):
    result = await request.app['pool'].fetch('SELECT * FROM brand')
    return web.json_response(dict(map(lambda r: (r['brand_id'], r['brand_name']), result)))


app.add_routes(routes)
web.run_app(app)
