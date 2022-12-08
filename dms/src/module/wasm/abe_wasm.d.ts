/* tslint:disable */
/* eslint-disable */
/**
* @param {boolean} containPriv
* @param {string} uid
* @returns {any}
*/
export function abe_dump_key(containPriv: boolean, uid: string): any;
/**
* @param {string} uid
* @returns {any}
*/
export function abe_list_key(uid: string): any;
/**
* @returns {any}
*/
export function abe_remove_all_key(): any;
/**
* @param {string} nonce_from_kdc
* @returns {any}
*/
export function abe_gen_nonce_gen_key(nonce_from_kdc: string): any;
/**
* @param {string} key_id
* @returns {any}
*/
export function abe_request_active_key(key_id: string): any;
/**
* @param {string} challenge_response
* @param {string} key_id
* @returns {any}
*/
export function abe_active_key(challenge_response: string, key_id: string): any;
/**
* @returns {any}
*/
export function abe_current_key_info(): any;
/**
* @param {string} policy
* @param {Uint8Array} pt_bytes
* @returns {any}
*/
export function abe_encrypt(policy: string, pt_bytes: Uint8Array): any;
/**
* @param {string} sig_data
* @param {Uint8Array} hex_data
* @param {string} key_id
* @returns {any}
*/
export function abe_decrypt(sig_data: string, hex_data: Uint8Array, key_id: string): any;
/**
* @param {string} encrypted_key_data
* @param {string} attr
* @returns {any}
*/
export function abe_import_key_from_kdc(encrypted_key_data: string, attr: string): any;
