defmodule Solution do
  @spec xor_all_nums(nums1 :: [integer], nums2 :: [integer]) :: integer
  def xor_all_nums(nums1, nums2) do
    case { rem( length(nums1), 2),  rem( length(nums2), 2) } do
        {0, 0} -> 0
        {1, 0} -> Enum.reduce(nums2, 0, &Bitwise.bxor/2)
        {0, 1} -> Enum.reduce(nums1, 0, &Bitwise.bxor/2)
        {1, 1} -> Enum.reduce(nums2, 
                  Enum.reduce(nums1, 0, &Bitwise.bxor/2), 
                                        &Bitwise.bxor/2)
    end
  end
end
