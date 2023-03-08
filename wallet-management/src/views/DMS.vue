<template v-if="authState.isAuthenticated">
    <div class="home" v-cloak>
        <div class="row equal">
            <div class="col-sm-4">
                <div class="card border border-info">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4 class="card-title text-bold">Total Documents 
                                    <span class="material-icons fs-1r text-info">
                                            open_in_new
                                        </span>
                                </h4>
                                <div class="d-flex justify-content-between">
                                    <h2 class="card-text text-info">8</h2>
                                </div>
                            </div>
                            <div>
                                <div class="icon icon-shape bg-info text-white rounded-circle shadow">
                                    <span class="material-icons">
                                        description
                                    </span>
                                </div>
                            </div>
                        </div>
                        
                        
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="card border border-warning">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4 class="card-title text-bold">Pending Documents 
                                    <span class="material-icons fs-1r text-warning">
                                            open_in_new
                                        </span>
                                </h4>
                                <div class="d-flex justify-content-between">
                                    <h2 class="card-text text-warning">3</h2>
                                </div>
                            </div>
                            <div>
                                <div class="icon icon-shape bg-warning text-white rounded-circle shadow">
                                    <span class="material-icons">
                                        assignment
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
            <div class="col-sm-4">
                <div class="card border border-success">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h4 class="card-title text-bold">Signed Documents
                                    <span class="material-icons fs-1r text-success">
                                            open_in_new
                                        </span>
                                </h4>
                                <div class="d-flex justify-content-between">
                                    <h2 class="card-text text-success">5</h2>
                                </div>
                            </div>
                            <div>
                                <div class="icon icon-shape bg-success text-white rounded-circle shadow">
                                    <span class="material-icons">
                                        assignment_turned_in
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        <br>
        <div class="row">
            <div class="col">
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
                        <tr v-for="(tx, index) in userState?.dmsTransactions">
                            <th class="truncate" scope="row">
                                <a target="_blank" :href="'https://testnet.bscscan.com/tx/'+ tx.transactionHash">{{ tx.transactionHash }}</a>
                            </th>
                            <td class="truncate">{{  customTime(tx.timestamp) }}</td>
                            <td class="truncate">{{ tx.from }}</td>
                            <td class="truncate">{{ tx.to }}..</td>
                            <td>{{ formatAmount((tx.gasUsed * +tx.gasPrice)/10e17)  }} TBNB</td>
                        </tr>
                    </tbody>
                </table>
                </div>
                </div>
            </div>
            </div> 
        </div>
        <br>
    </div>
    
  </template>
<script>

export default {
  components: {
    
  },
  mounted() {
    if(!this.userState.dmsTransactions.length) {
      this.$store.dispatch("user/getTransactions", {type: 'service', clientId: "dms" })
    }
  },
  data() {
    return {

    }
  },
  methods: {
    formatAmount(amount) {
      return Math.round(amount*10000)/10000
    },
    customTime(time) {
        return dayjs(time*1000).fromNow();
    },
  },
  computed: {
    userState() {return this.$store.state.user },
    authState() {return this.$store.state.auth },
  },
}
</script>
<style scoped>
  .navigate-btn {
    color: var(--primary);
  }
  .card {
    height: 100%;
  }
  .bg-img-signed {
    background-image: url("https://cdn1.iconfinder.com/data/icons/thincons/100/menu-128.png");
    background-repeat: no-repeat
  }
  .home {
    font-family: 'Courier New', Courier, monospace;
  }
  icon {
  width: 4rem;
  height: 4rem;
}

    .icon-shape {
    display: inline-flex;
    padding: 18px;
    text-align: center;
    border-radius: 50%;
    align-items: center;
    justify-content: center;
    }
    .rounded-circle {
  border-radius: 50% !important;
}
.fs-1r {
    font-size: 1.5rem;
}
</style>