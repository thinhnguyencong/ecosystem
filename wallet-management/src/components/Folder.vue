<template>
    <div @click="handleAccessFolder(id)" class="tile folder">
        <span class="material-icons">folder</span>
      <h4>{{name}}</h4>
    </div>
</template>
<script>
export default {
  props: {
    id: String,
    name: String
  },
   methods: {
    handleAccessFolder() {
      this.$router.push('/folder/' + this.id )
    }
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
    padding: 35px 16px 25px;
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
</style>