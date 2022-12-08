<template>
    <!-- <div class="input-group key-select">
        <select :style="documentState.key.isActivated?'background-color: mediumaquamarine;color: aliceblue':''" v-model="selectedKey" class="custom-select" id="inputGroupSelect04">
            <option v-if="!documentState.key.isActivated"  disabled value="">Choose key...</option>
            <option v-for="(key, index) in listKey" :key="index">{{key}}</option>
        </select>
        <div class="input-group-append">
            <button @click="handleActivateKey" class="btn btn-outline-success" type="button">Activate</button>
        </div>
    </div> -->
</template>
<script>
// import {ABE_MODULE} from "../helpers/abe";
// export default {
//     data() {
//         return {
//             listKey: [],
//             selectedKey: this.$store.state.document.key.keyId ? this.$store.state.document.key.keyId : ""
//         }
//     },
//     mounted() {
//         ABE_MODULE.then((ABE) => {
// 			const listKeyResult = ABE.abe_list_key("")
// 			console.log(JSON.parse(listKeyResult.result));
//             this.listKey = JSON.parse(listKeyResult.result)
// 		})
//         // Call the API query method on page load  
//     },
//     methods: {
//         handleActivateKey() {
//             if(this.selectedKey) {
//                 ABE_MODULE.then(async (ABE) => {
//                     const res = ABE.abe_request_active_key(this.selectedKey);
//                     const nonce = res.nonce
//                     console.log("res", res);
//                     await this.$store.dispatch("user/signMessage", {message: nonce})
//                     console.log("this.$store.state.user.signature", this.$store.state.user.signature);
//                     const data =  ABE.abe_active_key(this.$store.state.user.signature.replace('0x',''), this.selectedKey)
//                     if(data.error) {
//                         alert('Activate key failed')
//                     }else {
//                         const name = ABE.abe_current_key_info()
//                         this.$store.dispatch("document/activateKey", name)
//                         alert('Activate key successfully')
//                     }
//                 })
//             }else {
//                 alert('Please select a key')
//             }
//         },
//     },
//     watch: {
        
//     },
//     computed: {
//         documentState() {return this.$store.state.document}
//     },
// }

</script>
<style scoped>
.key-select {
    min-width: 260px;
}
</style>