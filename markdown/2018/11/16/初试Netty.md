[@Title]:<>(初试Netty)
[@Date]:<>(2018-11-16 09:30:00)
[@Tags]:<>(Java,Netty)



关于Netty的详细介绍，我也不多说。如果有想知道的，请自行百度。

下面是关于Netty的简单使用。


在这里我是用的是maven，在pom中加入

```xml
<dependency>
    <groupId>io.netty</groupId>
    <artifactId>netty-all</artifactId>
    <version>4.1.31.Final</version>
</dependency>
```

我这里使用的是 4.1.31.Final 这个版本，虽然有5.x这个版本，但是5.x版本被废弃了。之后使用的话，会出6.x版本，现在先使用4.x的版本吧。

首先我们创建服务端

> Server.java

```Java
public class Server {
    public static void main(String[] args) {

        EventLoopGroup boss = new NioEventLoopGroup();
        EventLoopGroup worker = new NioEventLoopGroup();

        try {
            ServerBootstrap bootstrap = new ServerBootstrap()
                    .group(boss, worker)
                    .channel(NioServerSocketChannel.class)
                    .childHandler(new ChannelInitializer<NioSocketChannel>() {
                        @Override
                        protected void initChannel(NioSocketChannel ch) {
                            ch.pipeline().addLast(new ServerHandler());
                        }
                    })
                    .option(ChannelOption.SO_BACKLOG, 128)
                    .childOption(ChannelOption.SO_KEEPALIVE, true);
            ChannelFuture future = bootstrap.bind(8080).sync();
            future.channel().closeFuture().sync();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            worker.shutdownGracefully();
            boss.shutdownGracefully();
        }
    }
}
```

> ServerHandler.java

```Java
public class ServerHandler extends SimpleChannelInboundHandler {

    private ByteBuf buf;

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object msg) throws Exception {
        if (this.buf == null) this.buf = Unpooled.buffer();
        if (msg instanceof ByteBuf) this.buf.writeBytes((ByteBuf) msg);
    }

    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
        byte[] bytes = new byte[buf.readInt()];
        buf.readBytes(bytes);
        String text = new String(bytes, StandardCharsets.UTF_8);
        this.buf = null;
        System.out.println(text);
    }
}
```

然后是客户端

> Client.java

```Java
public class Client {
    public static void main(String[] args) {

        EventLoopGroup worker = new NioEventLoopGroup();
        try {
            Bootstrap bootstrap = new Bootstrap()
                    .group(worker)
                    .channel(NioSocketChannel.class)
                    .handler(new ChannelInitializer<NioSocketChannel>() {
                        @Override
                        protected void initChannel(NioSocketChannel ch) {
                            ch.pipeline().addLast(new ClientHandler());
                        }
                    });

            ChannelFuture future = bootstrap.connect(new InetSocketAddress("127.0.0.1", 8080)).sync();

            future.channel().closeFuture().sync();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            worker.shutdownGracefully();
        }
    }
}
```

> ClientHandler.java

```Java
public class ClientHandler extends SimpleChannelInboundHandler {

    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {
        ByteBuf buf = Unpooled.buffer();
        String text = "Hello";
        byte[] bytes = text.getBytes(StandardCharsets.UTF_8);
        buf.writeInt(bytes.length);
        buf.writeBytes(bytes);
        ctx.channel().writeAndFlush(buf);
    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object msg) throws Exception {

    }

}
```

结果

![1542333485877](https://4url.top/static/1542333485877.png)

这样就完成了Netty的基本使用
