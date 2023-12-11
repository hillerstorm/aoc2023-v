module days

import arrays

pub fn day_nine(input string) !(string, string) {
	lines := input.split_into_lines().map(it.split(' ').map(it.int()))

	mut part_one := 0
	mut part_two := 0

	for line in lines {
		mut diffs := arrays.window(line, size: 2).map(it[1] - it[0])
		mut first_numbers := [line[0], diffs[0]]
		part_one += line.last() + diffs.last()

		for {
			diffs = arrays.window(diffs, size: 2).map(it[1] - it[0])
			part_one += diffs.last()

			if diffs.all(it == 0) {
				break
			}

			first_numbers << diffs[0]
		}

		part_two += foldr(first_numbers, 0, fn (acc int, value int) int {
			return value - acc
		})
	}

	return part_one.str(), part_two.str()
}
