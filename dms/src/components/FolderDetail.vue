<template>
    <div :style="{width: '0'}">
        <div
        class="right-drawer"
        :style="{
            width: open ? '25vw' : '0',
            paddingLeft: open ? '10px' : '0',
        }"
        >
        <h1>Menu</h1>
        <h4>Home</h4>
        <h4>About</h4>
        <h4>Stories</h4>
        <h4>Testimonials</h4>
        <h4>Contact</h4>
        </div>
    </div>
    
</template>
<script>
export default {
    props: ['drawerVisible'],
    data() {
        return {
            open: false,
        };
    },
    watch: {
        drawerVisible: {
            immediate: true, 
            handler (newVal, oldVal) {
                console.log(newVal);
                this.open = newVal
            }
        }
    }
};
</script>

<style scoped>

.right-drawer {
  display: inline-block;
  top: 0;
  right: 0;
  width: 0; /* initially */
  overflow: hidden;
  height: 100vh;
  padding-left: 0; /* initially */
  border-left: 1px solid whitesmoke;
  background: white;
}

</style>
