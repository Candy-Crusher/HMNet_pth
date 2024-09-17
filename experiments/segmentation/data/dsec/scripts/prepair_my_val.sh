# # Hierarchical Neural Memory Network
# # 
# # Copyright (C) 2023 National Institute of Advanced Industrial Science and Technology
# # 
# # All rights reserved.
# # 
# # Redistribution and use in source and binary forms, with or without modification,
# # are permitted provided that the following conditions are met:
# # 
# #     * Redistributions of source code must retain the above copyright notice,
# #       this list of conditions and the following disclaimer.
# #     * Redistributions in binary form must reproduce the above copyright notice,
# #       this list of conditions and the following disclaimer in the documentation
# #       and/or other materials provided with the distribution.
# #     * Neither the name of {{ project }} nor the names of its contributors
# #       may be used to endorse or promote products derived from this software
# #       without specific prior written permission.
# # 
# # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# # "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# # LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# # A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# # CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# # EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# # PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# # PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# # LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# # NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# # SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
export PYTHONPATH=$PYTHONPATH:/home/xiaoshan/work/adap_v/HMNet_pth
while getopts ah OPT
do
    case $OPT in
        "a" ) FLAG_M=TRUE;;
        "h" ) FLAG_H=TRUE;;
          * ) echo "Usage: $CMDNAME [-a] [-h]" 1>&2
              exit 1;;
    esac
done

if [ "$FLAG_H" = "TRUE" ];then
    echo "Usage: ${0##*/} [-m] [-h]"
    echo "    -m  : Generate meta data. This may take long time and requires large cpu memory (>32GB)"
    echo "    -h  : Show this message"
    echo ""
    exit 0
fi


echo "=========================================="
echo " Start preprocessing"
echo "=========================================="

TRAIN=(
    zurich_city_00_a
    zurich_city_01_a
    zurich_city_02_a
    zurich_city_04_a
    zurich_city_05_a
    zurich_city_06_a
    zurich_city_07_a
    zurich_city_08_a
)

TEST=(
    zurich_city_13_a
    zurich_city_14_c
    zurich_city_15_a
)

# # mkdir -p my_train_evt
# # mkdir -p my_train_img
# # mkdir -p my_train_lbl
# # mkdir -p my_train_img_right
# mkdir -p my_test_evt
# mkdir -p my_test_img
# mkdir -p my_test_lbl
# # mkdir -p my_test_img_right
# mkdir -p my_list


# # for dir in ${TRAIN[@]};do
# #     ln -s $(readlink -f /home/xiaoshan/work/datasets/DSEC/events/$dir/events/left/events.h5) ./train_evt/${dir}_events.h5
# #     ln -s $(readlink -f /home/xiaoshan/work/datasets/DSEC/images/train/$dir/images/left/rectified) ./train_img/${dir}_images
# #     ln -s $(readlink -f /home/xiaoshan/work/datasets/DSEC/semantic_segmentation/train/$dir/11classes) ./train_lbl/${dir}_labels
# #     ln -s $(readlink -f  /home/xiaoshan/work/datasets/DSEC/images/train/$dir/images/right/rectified) ./train_img_right/${dir}_images
# # done


# for dir in ${TEST[@]};do
#     ln -s $(readlink -f /home/xiaoshan/work/datasets/DSEC/events/$dir/events/left/events.h5) ./my_test_evt/${dir}_events.h5
#     ln -s $(readlink -f /home/xiaoshan/work/adap_v/my_proj/data/DSEC/day/leftImg8bit/val/$dir) ./my_test_img/${dir}_images
#     ln -s $(readlink -f /home/xiaoshan/work/adap_v/my_proj/data/DSEC/day/gtFine/val/$dir) ./my_test_lbl/${dir}_labels
#     # ln -s $(readlink -f /home/xiaoshan/work/datasets/DSEC/images/test/$dir/images/right/rectified) ./my_test_img_right/${dir}_images
# done

# python ./scripts/make_my_image_info.py
# python ./scripts/make_my_label_info.py
# # python ./scripts/make_my_image_info_right.py


# # python ./scripts/preproc_events.py ./my_train_evt/ --num_chunks 10
# python ./scripts/preproc_events.py ./my_test_evt/ --num_chunks 10
# # python ./scripts/preproc_images_and_labels.py ./my_train_lbl/ --root ./ --input_type label --num_chunks 10
# # python ./scripts/preproc_images_and_labels.py ./my_train_img/ --root ./ --input_type image --num_chunks 10
# # python ./scripts/preproc_images_and_labels.py ./my_train_img_right/ --root ./ --input_type image --num_chunks 10
# python ./scripts/preproc_images_and_labels.py ./my_test_lbl/ --root ./ --input_type label --num_chunks 10
# python ./scripts/preproc_images_and_labels.py ./my_test_img/ --root ./ --input_type image --num_chunks 10
# # python ./scripts/preproc_images_and_labels.py ./my_test_img_right/ --root ./ --input_type image --num_chunks 10

echo "FLAG_M: $FLAG_M"
if [ "$FLAG_M" = "TRUE" ];then
    echo "=========================================="
    echo " Generating meta data"
    echo "=========================================="

    # mkdir -p ./list/train/
    mkdir -p ./my_list/test/
    # ls ./my_train_evt/*.hdf5 > ./my_list/train/events.txt
    # ls ./my_train_img/*.hdf5 > ./my_list/train/images.txt
    # ls ./my_train_lbl/*.hdf5 > ./my_list/train/labels.txt
    # ls ./my_train_img_right/*.hdf5 > ./my_list/train/images_right.txt

    ls ./my_test_evt/*.hdf5 > ./my_list/test/events.txt
    ls ./my_test_img/*.hdf5 > ./my_list/test/images.txt
    ls ./my_test_lbl/*.hdf5 > ./my_list/test/labels.txt
    # ls ./my_test_img_right/*.hdf5 > ./my_list/test/images_right.txt

    python ./scripts/save_my_video_duration.py
    # python ./scripts/make_event_meta.py train
    python ./scripts/make_my_event_meta.py test
    python ./scripts/merge_my_meta.py
fi




