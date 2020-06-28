NumberInfo = provider("number") 

def _producer_impl(ctx):
    ctx.actions.write(output = ctx.outputs.out, content = 'dummy content')
    output_depset = depset([ctx.outputs.out])
    my_provider = NumberInfo(number = 13)

    # This works.
    # return [DefaultInfo(files = output_depset), my_provider]

    # This does not work
    return [DefaultInfo(files = output_depset)].append(my_provider)

producer = rule(
    implementation = _producer_impl,
    attrs = {
        "out": attr.output(mandatory = True),
    },
)

def _consumer_impl(ctx):
    target = ctx.attr.src
    number = target[NumberInfo].number
    print ('number = %s' % number)

    return [
        DefaultInfo(files = target.files),
    ]

consumer = rule(
    implementation = _consumer_impl,
    attrs = {
        "src": attr.label(mandatory = True),
    },
)