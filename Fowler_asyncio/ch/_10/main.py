from aiohttp.web_response import Response
import asyncio
import random
from aiohttp import web

routes = web.RouteTableDef()


@routes.get('/products/{id}/inventory')
async def get_inventory(request) -> Response:
    sleep = random.randint(0, 3)
    inventory = random.randint(0, 100)

    await asyncio.sleep(sleep)
    return web.json_response(dict(inventory=inventory))


app = web.Application()
app.add_routes(routes)

web.run_app(app, port=8001)
