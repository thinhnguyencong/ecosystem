import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { useDispatch, useSelector } from 'react-redux';
import { loadCollection } from '../../services/collection/collectionSlice';

function Collection(props) {
    const dispatch = useDispatch()
    const status = useSelector((state) => state.collection.status)
    useEffect(() => {
        console.log("111")
        if(status === "idle"){
            dispatch(loadCollection())
        }
    }, [status, dispatch])
    const collection = useSelector((state) => state.collection.collection)
    return ( 
    
        <div className="max-w-full bg-cover bg-center bg-page-wireframe-2 min-h-screen">
            <div className="row text-center pt-24">
                {collection?.map((NFT, key) => {
                    const owner =  NFT.owner
                    return(
                        <div key={key} className="col-md-2 m-3 pb-3 card border-secondary bg-black-light">
                            {/* <div className={"card-body"}>       
                                <h5 className="card-title">{NFT.title}</h5>
                            </div> */}
                            <a href={"/token/"+NFT.id} target="_blank" rel="noopener noreferrer">
                                <img src={`${NFT.img}`} className="card-img-bottom" alt={`NFT ${key}`} />
                            </a>                   
                            <p className="fw-light fs-6 text-white">{`${owner.substr(0,7)}...${owner.substr(owner.length - 7)}`}</p>
                        </div>
                    );
                })}
            </div>
        </div>
        
    );
}

export default Collection;