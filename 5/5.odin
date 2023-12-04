package main;

import "core:fmt";
import "core:strings";
import "core:strconv";
import "core:time";
import "../utils";

main :: proc()
{
    stopwatch : time.Stopwatch;
    time.stopwatch_start(&stopwatch);

    lines := [dynamic]string{};
    ok := utils.read_file_by_lines("./5/example.txt", &lines);
    if !ok
    {
        fmt.println("Unable to read file!");
        return;
    }

    for line in lines
    {
        fmt.println(line)
    }

    time.stopwatch_stop(&stopwatch);

    fmt.printf("Time: %vms", time.duration_milliseconds(stopwatch._accumulation));
}