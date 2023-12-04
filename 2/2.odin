package main

import "core:fmt";
import "core:strings";
import "core:time";
import "../utils";

score :: proc(a: int, b: int) -> int 
{
    return a + 1 + ((4 + a - b) % 3) * 3;
}

to_play :: proc(them : int, result : int) -> int 
{
    return (3 + them + (result - 1)) % 3;
}

main :: proc() 
{
    stopwatch : time.Stopwatch;
    time.stopwatch_start(&stopwatch);

    lines := [dynamic]string{};
    ok := utils.read_file_by_lines("./2/input.txt", &lines);
    if !ok 
    {
        fmt.println("Failed to read file");
        return;
    }

    part1 := 0;
    part2 := 0;
    for line in lines
    {
        them := int(line[0] - 'A');
        me := int(line[2] - 'X');

        part1 += score(me, them);
        part2 += score(to_play(them, me), them);
    }

    time.stopwatch_stop(&stopwatch);

    fmt.println("Score in part 1:", part1);
    fmt.println("Score in part 2:", part2);
    fmt.printf("Time: %vms", time.duration_milliseconds(stopwatch._accumulation));
}
