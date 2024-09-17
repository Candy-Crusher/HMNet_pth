export PYTHONPATH="/home/xiaoshan/work/adap_v/HMNet_pth"
python ./scripts/test.py ./config/hmnet_L3.py \
    ./data/dsec/my_list/test/ \
    ./data/dsec/ \
    --speed_test --fast \
    --pretrained ./pretrained/dsec_hmnet_L3.pth