#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
#include <string.h>

#include "sensor.pb-c.h"

int main()
{
    uint32_t    len;
    uint8_t     *buf;
    FILE        *write_ptr;
    Sensor      s;

    sensor__init(&s);
    s.name = "sensor-jpi";
    s.temperature = 99;
    s.humidity = 77;
    s.door = 1;
    s.jpi_test = 20;
    len = sensor__get_packed_size(&s);
    buf = malloc(len);
    sensor__pack(&s,buf);
    write_ptr = fopen("sensor.data","wb");
    fwrite(buf, len, 1, write_ptr);
    fclose(write_ptr);

    printf("Writing %d serialized bytes\n",len);
    free(buf);
    return 0;
}
