package merger

func MergeSlices[T any](slices ...[]T) (merged_slice []T) {
	for _, slice := range slices {
		merged_slice = append(merged_slice, slice...)
	}
	return
}
