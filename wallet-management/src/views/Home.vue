<template v-if="authState.isAuthenticated">
  <div class="home" v-cloak>
    <div class="row equal">
      <div class="col-sm-5">
        <div class="column h-100">
          <div class="col">
            <div class="card border border-primary">
              <div v-if="!userState.isLoading" class="card-body">
                <p class="card-title">{{userState.publicAddress}} <span class="material-icons fs-1r">
                content_copy
                </span></p>
                
                <h5 class="card-text font-weight-bold">Balance: {{formatAmount(userState.balance)}} TBNB</h5>
                <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalSendToken">Send <i class="mdi mdi-send text-light"></i></a>
              </div>
              <div v-else class="spinner-border text-dark" role="status">
                    <span class="sr-only">Loading...</span>
              </div>
            </div>
          </div>
          <br>
          <div class="col">
            <div class="card h-100 border border-secondary">
              <div class="card-body">
                <h5 class="card-title">Token</h5>
                <ul class="list-group">
                  <li
                      class="text-primary list-group-item d-flex justify-content-start align-items-center list-group-item-action add-token-btn"
                      data-toggle="modal" data-target="#modalAddToken" role="button"
                  >
                    <span class="material-icons md-36">add</span>
                    <span>Add Token</span>
                    
                  </li>
                  <li class="list-group-item d-flex justify-content-between align-items-center list-group-item-action"
                      v-for="(item, index) in userState.assets" :key="index">
                      <div class="d-inline">
                        <jazzicon :address="item.address" :diameter="40" />
                        <span>&nbsp; &nbsp;{{item.amount}} &nbsp; {{item.name}}</span>
                      </div>
                      <span @click="handleDeleteToken(item.address)" class="material-icons md-36 text-danger" role="button">delete</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-7">
        <div class="card h-100 border border-secondary">
          <div class="card-body">
            <h5 class="card-title">Transactions</h5>
            <div class="table-responsive">
              <table id="transactionsTable" class="table table-hover" data-pagination="true">
              <thead>
                <tr>
                  <th scope="col">Transaction Hash</th>
                  <th scope="col">Age</th>
                  <th scope="col">From</th>
                  <th scope="col">To</th>
                  <th scope="col">TxnFee</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <th scope="row">
                    <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                  </th>
                  <td class="text-truncate">40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                  <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
                <tr>
                  <th scope="row">
                    <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                  </th>
                  <td class="text-truncate">40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                   <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
                <tr>
                  <th scope="row">
                    <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                  </th>
                  <td class="text-truncate">40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                   <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
                <tr>
                  <th scope="row">
                    <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                  </th>
                  <td class="text-truncate">40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                   <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
              </tbody>
            </table>
            </div>
            <nav aria-label="...">
              <ul class="pagination justify-content-end">
                <li class="page-item disabled">
                  <span class="page-link">Previous</span>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item">
                  <span class="page-link">
                    2
                    <span class="sr-only">(current)</span>
                  </span>
                </li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#">Next</a>
                </li>
              </ul>
            </nav>
          </div>
        </div>
      </div>  
      
    </div>
    <div class="modal fade" id="modalSendToken" tabindex="-1" role="dialog" aria-labelledby="modalSendTokenTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Send</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label for="address">Account address</label>
                <input v-model="address" type="text" class="form-control" id="address" placeholder="Public address">
              </div>
              <div class="form-group">
                <label for="asset">Asset</label>
                <select class="form-control" id="asset" v-model="assetSelected">
                  <option selected disabled value="">Select token</option>
                  <option v-for="(item, index) in assets" :key="index" :value="item" >{{item.name}} &nbsp; ({{formatAmount(item.amount)}})</option>
                </select>
              </div>
              <div class="form-group">
                <label for="amount">Amount</label>
                <input v-model="amount" type="text" class="form-control" id="amount" placeholder="Public address">
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" @click="handleSendToken" data-dismiss="modal">Send</button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="modalAddToken" tabindex="-1" role="dialog" aria-labelledby="modalAddTokenTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Add Token</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label for="address">Token address</label>
                <input v-model="tokenAddress" type="text" class="form-control" id="address" placeholder="Address">
              </div>
              <div class="form-group">
                <label for="name">Name</label>
                <input v-model="tokenName" type="text" class="form-control" id="name" placeholder="Name">
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" @click="handleAddToken" data-dismiss="modal">Add Token</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  
</template>

<script>
export default {
  data() {
    return {
      address: "",
      amount: 0,
      assetSelected: "",
      tokenAddress: "",
      tokenName: "",
      assets: []
    }
  },
  methods: {
    handleAddToken() {
        let data = {
          address: this.tokenAddress,
          name: this.tokenName
        }
        this.$store.dispatch("user/addAsset", data)
        this.$store.dispatch("user/getUserInfo", {tokens: localStorage.getItem("tokenList") })
        this.tokenAddress= ""
        this.tokenName= ""
    },
    handleDeleteToken(address) {
      this.$store.dispatch("user/removeAsset", address)
      this.$store.dispatch("user/getUserInfo", {tokens: localStorage.getItem("tokenList") })
    },
    handleSendToken() {
      console.log(this.assetSelected);
      // let obj = assets.find(x => x.address === event.target.value)
		  // console.log(obj);
      let data = {
        addressTo: this.address,
        amount: this.amount,
        asset: {
          name: this.assetSelected.name,
          address: this.assetSelected.address,
          type: this.assetSelected.type
        }
      }
      this.$store.dispatch("user/transferToken", data)
    },
    getAllAssets() {
      // let tokenList = JSON.parse(localStorage.getItem("tokenList"))
      // let output = Object.entries(tokenList).map(([key, value]) => ({address: key, name: value.name, type: value.type}));
      // let result = output.map(o => ({}))
      let assets =  JSON.parse(JSON.stringify(this.userState.assets))
      assets.unshift({address: "0x0000000000000000000000000000000000000000", amount: this.userState.balance, name: "tBNB", type:"native" })
      this.assets= assets
      console.log(assets);
    },
    formatAmount(amount) {
      return Math.round(amount*10000)/10000
    }
  },
  mounted() {
    //this.$store.dispatch("auth/findUser")
    this.$store.dispatch("user/getUserInfo", {tokens: localStorage.getItem("tokenList") })
    this.$store.dispatch("user/getAsset")
  },
  computed: {
    userState() {return this.$store.state.user },
    authState() {return this.$store.state.auth },
  },
  watch: {
    '$store.state.user.assets': {
      handler() {
        this.getAllAssets();
      },
      immediate: true
    } 
  }
}
</script>

<style>
[v-cloak] {
  display: none;
}
tr {
   line-height: 25px;
   min-height: 25px;
   height: 60px;
}
.row-eq-height {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display:         flex;
 }
 .h-100 {
  height: 100%
 }
 .material-icons {
  font-size: 2rem;
 }
 .fs-1r {
  font-size: 1rem;
 }

</style>
