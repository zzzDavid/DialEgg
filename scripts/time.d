#!/usr/sbin/dtrace -s

#pragma D option quiet

proc::exec:exec-success
/execname == $$1/
{
    self->start = timestamp;
}

proc::exit:exit
/execname == $$1/
{
    this->elapsed = (timestamp - self->start) / 1000000000;
    printf("Execution time: %.9f seconds\n", this->elapsed);
}