module days

fn test_day_nine() {
	run_tests(day_ten, [
		TestFixture{
			buffer: read_input(day: 10, version: 1)
			expected_part_one: '8'
			expected_part_two: '1'
		},
		TestFixture{
			buffer: read_input(day: 10, version: 2)
			expected_part_two: '10'
		},
	])
}
