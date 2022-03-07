CFLAGS=$(shell pkg-config --cflags 'libprotobuf-c >= 1.0.0')
LD_FLAGS=$(shell pkg-config --libs 'libprotobuf-c >= 1.0.0')

OBJS = sensor.pb-c.o sensor.o


%.o: %.c
	gcc -g -c -o $@ $< $(CFLAGS)


.PHONY: all
all: sensor sensor_pb2.py

sensor: $(OBJS)
	gcc -g $(OBJS) -o $@ $(LD_FLAGS)

sensor.pb-c.c: sensor.proto
	protoc-c --c_out=. $<

sensor_pb2.py: sensor.proto
	protoc -I=. --python_out=. $<

.PHONY: clean

clean:
	rm -fr *.o sensor sensor.pb-c.c sensor.pb-c.h sensor_pb2.py __pycache__ sensor_pb2.pyc sensor.data
