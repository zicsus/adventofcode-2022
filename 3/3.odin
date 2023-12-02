package main;

import "core:fmt";
import "core:slice";
import "../utils";

to_int_array :: proc(line: string, arr: ^[dynamic]int)
{
    for i in 0..<len(line)
    {
        append(arr, int(line[i] - 'A' + 1));
    }
}

main :: proc()
{
    lines := [dynamic]string{};

    ok := utils.read_file_by_lines("./3/input.txt", &lines);
    if !ok
    {
        fmt.println("Cannot read the file");
    }

    part1 := 0;
    part2 := 0;

    for line, index in lines
    {
        l1 := [dynamic]int{};
        to_int_array(line, &l1);

        compartment_a := l1[:len(line) / 2];
        compartment_b := l1[(len(line) / 2) + 1:len(line)];

        slice.sort(compartment_a[:]);
        slice.sort(compartment_b[:]);

        common := -1;
        for item in compartment_a
        {
            if (utils.binary_search(compartment_b, item))
            {
                common = item;
                break;
            }
        }

        if (common != -1)
        {
            part1 += (common > 26) ? common - 32 : common + 26;
        }

        if (index % 3 == 0 && index < cap(lines) - 2) 
        {
            l2 := [dynamic]int{};
            l3 := [dynamic]int{};

            to_int_array(lines[index + 1], &l2);
            to_int_array(lines[index + 2], &l3);

            slice.sort(l1[:]);
            slice.sort(l2[:]);
            slice.sort(l3[:]);

            common := -1;
            for item in l1
            {
                if (
                    utils.binary_search(l2[:], item) &&
                    utils.binary_search(l3[:], item)
                )
                {
                    common = item;
                }
            }

            if (common != -1)
            {
                part2 += (common > 26) ? common - 32 : common + 26;
            }
        }
    }

    fmt.println(part1, part2);
}
