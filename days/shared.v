module days

import os

struct TestFixture {
	buffer            string
	expected_part_one string
	expected_part_two string
}

struct TestInputConfig {
	day     int
	version int = 1
}

fn read_input(config TestInputConfig) string {
	input_path := 'days/test_inputs/day_${config.day:02}_${config.version:02}.txt'

	if os.exists(input_path) {
		return os.read_file(input_path) or { panic(err) }
	}

	panic('invalid input file: ${input_path}')
}

fn run_tests(day fn (input string) !(string, string), tests []TestFixture) {
	for test in tests {
		part_one, part_two := day(test.buffer) or { panic(err) }
		if test.expected_part_one != '' {
			assert part_one == test.expected_part_one
		}
		if test.expected_part_two != '' {
			assert part_two == test.expected_part_two
		}
	}
}

fn foldr[T, R](array []T, init R, fold_op fn (acc R, elem T) R) R {
	mut value := init

	for i := array.len - 1; i >= 0; i-- {
		value = fold_op(value, array[i])
	}

	return value
}
