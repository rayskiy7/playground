package merger

import (
	"reflect"
	"testing"
)

func assert[T any](t *testing.T, slices [][]T, result []T) {
	if ok := reflect.DeepEqual(MergeSlices(slices...), result); !ok {
		t.Errorf("failed case: %v => %v\n", slices, result)
	}
}

func TestMergeSlices(t *testing.T) {
	assert(t, [][]int{{1, 2, 3}, {4, 5}}, []int{1, 2, 3, 4, 5})
	assert(t, [][]int16{{5, 7}, {10}, {33}}, []int16{5, 7, 10, 33})
}
