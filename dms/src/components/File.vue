<template>
    <div>
        <div class="tile file">
            <span class="file-icon">
                <i :class="getClassFileType(fileType)"></i>
            </span>
        <h5 class="truncate">{{name}}</h5>
        </div>
    </div>
</template>
<script>
import {getClassFileType} from "../helpers/index"
import $ from 'jquery' 
export default {
    props: {
        id: String,
        fileType: String,
        name: String,
        file: Object
    },
   methods: {
        getClassFileType: getClassFileType,
   },
    mounted() {
        
    }
}

</script>

<style scoped>
.tile {
    border-radius: 3px;
    width: 200px;
    height: 100%;
    margin-bottom: 23px;
    text-align: center;
    border: 1px solid #eeeeee;
    transition: 0.2s all cubic-bezier(0.4, 0.0, 0.2, 1);
    position: relative;
    padding: 3.5rem 1rem 3rem;
    margin-right: 17px;
    cursor: pointer;
}
.tile:hover{
  box-shadow: 0px 7px 5px -6px rgba(0, 0, 0, 0.12);
  background-color: #eeeeee;
  border: 1px solid #dddddd;
}
.tile .material-icons{
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
}
.file-icon {
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
}
.truncate {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; 
}
</style>