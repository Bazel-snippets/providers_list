load(":rules.bzl", "producer", "consumer")

producer(
    name = 'producer',
    out = 'dummy.txt',
)

consumer(
    name = 'consumer',
    src = ':producer',
)