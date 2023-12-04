module days

import arrays

const all_numbers = [
	'0',
	'1',
	'2',
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
	'9',
	'zero',
	'one',
	'two',
	'three',
	'four',
	'five',
	'six',
	'seven',
	'eight',
	'nine',
]

struct Match {
	value string
	idx   int
}

pub fn day_one(input string) !(string, string) {
	lines := input.split_into_lines()

	part_one := arrays.sum(lines
		.map(it.split('').filter(it in days.all_numbers[..10]))
		.filter(it.len > 0)
		.map((it.first() + it.last()).int()))!

	part_two := arrays.sum(lines
		.map(fn (line string) int {
			mut first_indices := days.all_numbers
				.filter(line.index(it) or { -1 } > -1)
				.map(Match{it, line.index(it) or { -1 }})
			first_indices.sort(a.idx < b.idx)
			first_num := days.all_numbers[days.all_numbers.index(first_indices.first().value) % 10]

			mut last_indices := days.all_numbers
				.filter(line.index(it) or { -1 } > -1)
				.map(Match{it, line.last_index(it) or { -1 }})
			last_indices.sort(a.idx < b.idx)
			last_num := days.all_numbers[days.all_numbers.index(last_indices.last().value) % 10]

			return (first_num + last_num).int()
		}))!

	return part_one.str(), part_two.str()
}
