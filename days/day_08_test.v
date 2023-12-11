module days

fn test_day_eight() {
	run_tests(day_eight, [
		TestFixture{
			buffer: read_input(day: 8, version: 1)
			expected_part_one: '2'
		},
		TestFixture{
			buffer: read_input(day: 8, version: 2)
			expected_part_one: '6'
		},
		TestFixture{
			buffer: read_input(day: 8, version: 2)
			expected_part_two: '6'
		},
	])
}
