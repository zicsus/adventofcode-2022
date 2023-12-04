package main;

import "core:fmt";
import "core:strconv";
import "core:sort";
import "core:time";
import "../utils";


main :: proc()
{
    stopwatch : time.Stopwatch;
    time.stopwatch_start(&stopwatch);

    lines := [dynamic]string{};
    ok := utils.read_file_by_lines("./1/input.txt", &lines);

    calories := [dynamic]int{};
    sum := 0;   
    for line in lines 
    {
        if (len(line) == 0) 
        {
            append(&calories, sum);
            sum = 0; 
            continue;
        }

        colorie, ok := strconv.parse_int(line);
        if !ok 
        {
            fmt.println("Failed to convert to int");
            break;
        }

        sum += colorie;
    }

    sort.quick_sort(calories[:len(calories)]);
    
    highest := calories[len(calories) - 1];
    top3 := calories[len(calories) - 1] + 
            calories[len(calories) - 2] + 
            calories[len(calories) - 3];

    time.stopwatch_stop(&stopwatch);

    fmt.println("Highest calorie:", highest);
    fmt.println("Sum of top 3 calories:", top3)
    fmt.printf("Time: %vms", time.duration_milliseconds(stopwatch._accumulation));
}