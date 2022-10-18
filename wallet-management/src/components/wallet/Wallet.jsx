
import Web3 from "web3";
import lightwallet from "eth-lightwallet"
import { useEffect, useState } from "react";
import NiceToken from "../../NiceToken.json";

const contractAddress = "0xbE2D5296310C8777B840FEf5Fe5F962c15E081ea"
function Wallet() {
	const [newAccountBalance, setNewAccountBalance] = useState(null)
	const [newAccountAddress, setNewAccountAddress] = useState(null)
	const [phrase, setPhrase] = useState("")
	const [privateKey, setPrivateKey] = useState(null)
	const [keyStore, setKeyStore] = useState(null)
	const [balance, setbalance] = useState(0);
	const [account, setAccount] = useState("");
	const [niceContract, setContract] = useState(null);
	const [recipient, setRecipient] = useState("");
	const [amount, setAmount] = useState("");
	const [accounts, setAccounts] = useState([]);

  useEffect(() => {
	const loadWeb3 = async () => {
		// Connect to Local blockchain network
		window.web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		// To Connect to MetaMask
		// window.web3 = new Web3(window.ethereum);
	};

	const loadBlockchainData = async () => {
	  const web3 = window.web3;
	  const niceContractAddress = "0xbE2D5296310C8777B840FEf5Fe5F962c15E081ea"; // Contract Address Here
	  const niceTokenContract = new web3.eth.Contract(
		NiceToken.abi,
		niceContractAddress
	  );
	  setContract(niceTokenContract);
	};
	console.log("lightwallet", lightwallet)
	loadWeb3();
	loadBlockchainData();
  }, []);

  const setAccountDetails = async (niceContract, accountValue) => {
	const web3 = window.web3;
	setAccount(accountValue);
	const balance = await niceContract.methods.balanceOf(accountValue).call();
	setbalance(web3.utils.fromWei(balance.toString()));
  };

  const createNewWallet = () => {
	var randomSeed = lightwallet.keystore.generateRandomSeed();

	var infoString = 'Your new wallet seed is: "' + randomSeed +
	  '". Please write it down on paper or in a password manager, you will need it to access your wallet. Do not let anyone see this seed or they can take your Ether. ' +
	  'Please enter a password to encrypt your seed while in the browser.';
	var password = prompt(infoString, 'Password');

	lightwallet.keystore.createVault({
	  password: password,
	  seedPhrase: randomSeed,
	  //random salt
	  hdPathString: 'm/0\'/0\'/0\''
	}, function (err, ks) {
		setKeyStore(ks)
		console.log("ks", ks);
		ks.keyFromPassword(password, function (err, pwDerivedKey) {
			if (err) throw err;
			ks.generateNewAddress(pwDerivedKey, 1) 
			let addr = ks.getAddresses();
			setNewAccountAddress(addr[0])
			getBalance(addr[0])
	  	})
	});
  }
  const restoreWallet = () => {
	var password = prompt('Enter Password to encrypt your seed', 'Password');

		lightwallet.keystore.createVault({
			password: password,
			seedPhrase: document.getElementById('seed').value,
			//random salt
			hdPathString: 'm/0\'/0\'/0\''
		}, function (err, ks) {
			setKeyStore(ks)
			console.log("ks", ks)
			console.log("ks serialize", ks.serialize())
			console.log("ks deserialize", lightwallet.keystore.deserialize(ks.serialize()))
			ks.keyFromPassword(password, function (err, pwDerivedKey) {
				if (err) throw err;
				ks.generateNewAddress(pwDerivedKey, 1) 
				let addr = ks.getAddresses();
				setNewAccountAddress(addr[0])
				getBalance(addr[0])
			  })
        });
  }
  async function getBalance(address) {
	const web3 = window.web3;
	let bal = await web3.eth.getBalance(address)
	setNewAccountBalance(web3.utils.fromWei(bal))
  }
	const onChangePhrase = (e) => {
		setPhrase(e.target.value)
	}
	const exportPrivateKey = () => {
		var password = prompt("Type your password", 'Password');
		console.log("ks", keyStore.getAddresses())
		keyStore.keyFromPassword(password, function (err, pwDerivedKey) {
			if (err) throw err;
			console.log("newAccountAddress", newAccountAddress)
			let privateKey = keyStore.exportPrivateKey(newAccountAddress, pwDerivedKey)
			setPrivateKey(privateKey)
		})

	}
  return (
	<div className="pt-24">
		<h2>New Wallet</h2>
		<div>
			<button onClick={createNewWallet}>Create New Wallet</button>
		</div>
		<h2>Restore Wallet</h2>
		<div>
			<input id="seed" size="80" type="text" onChange={onChangePhrase} value={phrase} />
			<button onClick={restoreWallet}>Restore Wallet</button>
		</div>
		<h2>Export private key</h2>
		<div>
			<button onClick={exportPrivateKey}>Export Private Key</button>
		</div>
		<div>
			{newAccountAddress ? 
				<h5>Wallet address : {newAccountAddress}</h5>
				: ""
			}
			{newAccountBalance ? 
				<h5>Balance: {newAccountBalance}</h5>
				: ""
			}
			{privateKey ? 
				<h5>Private Key: {privateKey}</h5>
				: ""
			}
		</div>
	</div>
  );
}

export default Wallet;