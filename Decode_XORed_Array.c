int* decode(int* encoded, int encodedSize, int first, int* returnSize){
    int* result = (int*)malloc(sizeof(int)*(encodedSize+1));
    for(int i=0;i<=encodedSize;i++){
        if(i==0){
            result[i]=first;
        }
        else{
            result[i]=result[i-1] ^ encoded[i-1];
        }
        
    }
    *returnSize = encodedSize+1;
    return result;
}
