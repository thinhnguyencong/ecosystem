<template v-if="authState.isAuthenticated">
  <div class="home" v-cloak>
    <div class="row equal">
      <div class="col-sm-5">
        <div class="column h-100">
          <div class="col">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">{{userState.publicAddress}}</h5>
                <p class="card-text">Balance: {{Math.round(userState.balance*10000)/10000}} TBNB</p>
                <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modalSendToken">Send</a>
              </div>
            </div>
          </div>
          <br>
          <div class="col">
            <div class="card h-100">
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
                      <div>
                        <img src="https://cdn1.iconfinder.com/data/icons/thincons/100/menu-128.png" width="40" />
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
        <div class="card h-100">
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
                  <td>40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                  <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
                <tr>
                  <th scope="row">
                    <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                  </th>
                  <td>40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                   <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
                <tr>
                  <th scope="row">
                    <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                  </th>
                  <td>40 days 2 hrs ago</td>
                  <td>0x09876c96f802471849..</td>
                   <td>0xb8262489b64477e886..</td>
                  <td>0.00028181 BNB</td>
                </tr>
              </tbody>
            </table>
            </div>
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
                <label for="amount">Amount</label>
                <input v-model="amount" type="text" class="form-control" id="amount" placeholder="Public address">
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" @click="handleSendToken">Save changes</button>
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
      tokenAddress: "",
      tokenName: ""
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

  },
  },
  mounted() {
    //this.$store.dispatch("auth/findUser")
    this.$store.dispatch("user/getUserInfo", {tokens: localStorage.getItem("tokenList") })
    this.$store.dispatch("user/getAsset")
  },
   computed: {
    userState() {return this.$store.state.user },
    authState() {return this.$store.state.auth }
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
</style>
