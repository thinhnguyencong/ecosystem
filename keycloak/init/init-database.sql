-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: Feb 21, 2023 at 08:19 AM
-- Server version: 5.7.40
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `keycloak-db`
--

-- --------------------------------------------------------

--
-- Table structure for table `ADMIN_EVENT_ENTITY`
--

CREATE TABLE `ADMIN_EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `ADMIN_EVENT_TIME` bigint(20) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `AUTH_REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_CLIENT_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `RESOURCE_PATH` varchar(2550) DEFAULT NULL,
  `REPRESENTATION` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ASSOCIATED_POLICY`
--

CREATE TABLE `ASSOCIATED_POLICY` (
  `POLICY_ID` varchar(36) NOT NULL,
  `ASSOCIATED_POLICY_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `AUTHENTICATION_EXECUTION`
--

CREATE TABLE `AUTHENTICATION_EXECUTION` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `AUTHENTICATOR` varchar(36) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `REQUIREMENT` int(11) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `AUTHENTICATOR_FLOW` bit(1) NOT NULL DEFAULT b'0',
  `AUTH_FLOW_ID` varchar(36) DEFAULT NULL,
  `AUTH_CONFIG` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AUTHENTICATION_EXECUTION`
--

INSERT INTO `AUTHENTICATION_EXECUTION` (`ID`, `ALIAS`, `AUTHENTICATOR`, `REALM_ID`, `FLOW_ID`, `REQUIREMENT`, `PRIORITY`, `AUTHENTICATOR_FLOW`, `AUTH_FLOW_ID`, `AUTH_CONFIG`) VALUES
('004bd5e0-52cb-49b7-9d58-0f41e65f04d2', NULL, 'auth-username-password-form', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ce45a0ad-ff74-4701-9205-1b2faca55d27', 0, 10, b'0', NULL, NULL),
('00b04a34-75db-4fbe-b5b3-3ab59bd0d10c', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'a4ce7cb2-f6b1-4dea-9198-5be9742e0b88', 0, 20, b'1', 'fbb62cf2-9cfc-4b29-b450-b6e20cce8ce2', NULL),
('0114cf05-dd63-49a6-9756-2666edf59f0a', NULL, 'conditional-user-configured', 'ad3a9024-ffab-4299-a385-b777720941f3', '651d4dcc-27da-4920-a688-2d7cf37ef316', 0, 10, b'0', NULL, NULL),
('0669853b-6057-463f-a930-a5ab37b7c7f7', NULL, 'identity-provider-redirector', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '19f228f3-6ce7-4ac0-93e1-4381219fc7e8', 2, 25, b'0', NULL, NULL),
('06a16958-7b24-4ab3-957f-471e8adee8c3', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', '0cb851a2-a518-4db7-86b3-94dcdbd89c70', 0, 20, b'1', '72f5bf46-c8e7-4422-b275-8b1a444aec59', NULL),
('0b0b4076-fa26-42ba-98fa-2fa8a74022c0', NULL, 'basic-auth', 'ad3a9024-ffab-4299-a385-b777720941f3', '06b1f5c1-52b9-4b0b-8e66-926985b210db', 0, 10, b'0', NULL, NULL),
('0d7e4031-7eaa-4f4f-a729-a0eb67669da6', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'dffe8420-9527-4f36-982f-abf4450a4149', 0, 20, b'1', 'f6397b7d-7159-4c5d-aa4b-1ac1403da318', NULL),
('1087468c-dd47-4c8f-92f2-37ed61e99051', NULL, 'registration-page-form', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '6b26c06e-4f90-4a3d-8db4-f83f6bb7f71c', 0, 10, b'1', '039ac1b6-c183-4339-8362-e91e7b0d0000', NULL),
('1438a4d9-49e5-4572-93bc-790b6d72cd59', NULL, 'client-jwt', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '020df459-1d47-4349-99f9-0cb7301cbe50', 2, 20, b'0', NULL, NULL),
('14f9b92f-a244-4429-8f9f-15a8b8f66812', NULL, 'no-cookie-redirect', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'a4ce7cb2-f6b1-4dea-9198-5be9742e0b88', 0, 10, b'0', NULL, NULL),
('1705f186-9851-45d6-8a58-77077df998b1', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', '72f5bf46-c8e7-4422-b275-8b1a444aec59', 2, 20, b'1', 'eba4ebff-04f9-42e7-b372-24aca87d5ec4', NULL),
('1fb7cb82-270a-476e-8809-63afe1d7fe2d', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', 'eba4ebff-04f9-42e7-b372-24aca87d5ec4', 0, 20, b'1', '43a89e5f-3fed-4871-a091-980ccfa7ef17', NULL),
('2229b4d0-f487-4363-832b-89ab260858ca', NULL, 'reset-credentials-choose-user', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '00f7c37a-0aa6-4910-b323-99ce02cc6585', 0, 10, b'0', NULL, NULL),
('249d921c-f7aa-4ea4-a85c-363d36469b9b', NULL, 'idp-create-user-if-unique', 'ad3a9024-ffab-4299-a385-b777720941f3', '72f5bf46-c8e7-4422-b275-8b1a444aec59', 2, 10, b'0', NULL, '5bc05047-593c-466a-af19-3d43ba4268e4'),
('277acecc-ba64-4281-a6f3-b2a243b330e8', NULL, 'idp-review-profile', 'ad3a9024-ffab-4299-a385-b777720941f3', '0cb851a2-a518-4db7-86b3-94dcdbd89c70', 0, 10, b'0', NULL, '95ca9527-dbe1-4a48-a068-ab07ac329167'),
('316e3ada-8ecb-40b9-ba7a-1d6def52eb51', NULL, 'conditional-user-configured', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f64821e1-5c2d-49d8-9e75-ef6533f930aa', 0, 10, b'0', NULL, NULL),
('31dd70b2-1315-423d-83f5-2a7a4dbd6380', NULL, 'idp-confirm-link', 'ad3a9024-ffab-4299-a385-b777720941f3', 'eba4ebff-04f9-42e7-b372-24aca87d5ec4', 0, 10, b'0', NULL, NULL),
('347c308b-d662-4b51-8023-8bc13e8c9e41', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', '41f703c6-402f-42fd-846f-1bd5a22bbfeb', 1, 20, b'1', 'f64821e1-5c2d-49d8-9e75-ef6533f930aa', NULL),
('35cf767c-1655-4584-90dc-fd1cd7560d39', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ebe6df3a-2a12-409f-9163-5d278a07609e', 0, 20, b'1', 'bb302fba-83b1-493e-b77f-bbe6c40f8cf9', NULL),
('37e791b2-955f-4a86-b871-75f65db0985c', NULL, 'direct-grant-validate-otp', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'd8ced537-5101-4de8-aaba-d4476d1fb38a', 0, 20, b'0', NULL, NULL),
('396e0467-ba1b-43f3-b01e-064890aec5b3', NULL, 'registration-password-action', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '039ac1b6-c183-4339-8362-e91e7b0d0000', 0, 50, b'0', NULL, NULL),
('3ad2b2ed-b6c5-44e4-badc-51f44585b570', NULL, 'registration-user-creation', 'ad3a9024-ffab-4299-a385-b777720941f3', 'd59742d4-6b67-4c38-9975-23058c5a8edd', 0, 20, b'0', NULL, NULL),
('42f1eb63-0858-4a60-8139-2c59c6b8e3f6', NULL, 'idp-email-verification', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'bb302fba-83b1-493e-b77f-bbe6c40f8cf9', 0, 10, b'0', NULL, NULL),
('434a9f94-ff6a-4b7b-ae05-74220e078e11', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', 'f83dbc35-cd12-48ec-b2dd-11fd277345b3', 1, 30, b'1', '70ebdac4-13be-4b05-89bf-915979b72ee7', NULL),
('461f8b07-7b46-4299-aa93-7e62359c8ae1', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '19f228f3-6ce7-4ac0-93e1-4381219fc7e8', 2, 30, b'1', 'ce45a0ad-ff74-4701-9205-1b2faca55d27', NULL),
('527686a2-dbef-4b74-ae52-a9ee84e34a3d', NULL, 'registration-password-action', 'ad3a9024-ffab-4299-a385-b777720941f3', 'd59742d4-6b67-4c38-9975-23058c5a8edd', 0, 50, b'0', NULL, NULL),
('53e5c403-b4d1-4316-aa3b-1328c23ac5ed', NULL, 'idp-username-password-form', 'ad3a9024-ffab-4299-a385-b777720941f3', 'a9114141-41b8-423d-8d43-1bc87e8aa5b0', 0, 10, b'0', NULL, NULL),
('5447fef8-6554-4bb7-89eb-0075bfa62a14', NULL, 'auth-spnego', 'ad3a9024-ffab-4299-a385-b777720941f3', '06b1f5c1-52b9-4b0b-8e66-926985b210db', 3, 30, b'0', NULL, NULL),
('54fd503d-7330-4bd1-b50e-a83742a33e53', NULL, 'direct-grant-validate-password', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '66c90ce5-99dd-4cfe-84b9-23aa0257a9cb', 0, 20, b'0', NULL, NULL),
('59ff79b0-b0ab-46c2-bab8-1c577f3049ee', NULL, 'basic-auth-otp', 'ad3a9024-ffab-4299-a385-b777720941f3', '06b1f5c1-52b9-4b0b-8e66-926985b210db', 3, 20, b'0', NULL, NULL),
('5a198c9f-adc9-4dc2-975a-2cd33dbff036', NULL, 'http-basic-authenticator', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '42e1d6f4-c416-49af-8aac-7031fea47450', 0, 10, b'0', NULL, NULL),
('5a221054-e247-4da8-971b-7d9cbd7e3699', NULL, 'docker-http-basic-authenticator', 'ad3a9024-ffab-4299-a385-b777720941f3', '6f11ed35-967b-4132-ba1a-8c26f5517a30', 0, 10, b'0', NULL, NULL),
('5be25ad5-c1d9-49ef-be60-f24c24d314be', NULL, 'client-secret', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '020df459-1d47-4349-99f9-0cb7301cbe50', 2, 10, b'0', NULL, NULL),
('5c9d4aab-e40f-4848-af20-9c9abccb439a', NULL, 'conditional-user-configured', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'd8ced537-5101-4de8-aaba-d4476d1fb38a', 0, 10, b'0', NULL, NULL),
('5d8da5ac-e2c8-44b6-a401-896eec62dc41', NULL, 'auth-spnego', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '19f228f3-6ce7-4ac0-93e1-4381219fc7e8', 3, 20, b'0', NULL, NULL),
('63ea1fbc-d430-4ffe-8526-7632abf07364', NULL, 'direct-grant-validate-otp', 'ad3a9024-ffab-4299-a385-b777720941f3', '70ebdac4-13be-4b05-89bf-915979b72ee7', 0, 20, b'0', NULL, NULL),
('640ca3f7-7ea2-4039-8177-07ec49f73b8b', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '66c90ce5-99dd-4cfe-84b9-23aa0257a9cb', 1, 30, b'1', 'd8ced537-5101-4de8-aaba-d4476d1fb38a', NULL),
('67d8c627-cea0-4c6c-9648-fa8d397f8360', NULL, 'client-x509', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '020df459-1d47-4349-99f9-0cb7301cbe50', 2, 40, b'0', NULL, NULL),
('69882a94-a475-4dd0-a97e-7cb6eb907510', NULL, 'direct-grant-validate-password', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f83dbc35-cd12-48ec-b2dd-11fd277345b3', 0, 20, b'0', NULL, NULL),
('6bb52686-19ca-46df-be92-9b059b1831d0', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', '60620ae7-7fb4-422a-9a49-8ea356674734', 2, 30, b'1', '41f703c6-402f-42fd-846f-1bd5a22bbfeb', NULL),
('6cc8947f-5a74-4264-9ac2-d91c5e2ce85a', NULL, 'reset-credentials-choose-user', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f03744cd-5a6e-4169-a4f1-a4303b83336e', 0, 10, b'0', NULL, NULL),
('6de72486-106c-4555-aa7c-8ae2a7a8713f', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ce45a0ad-ff74-4701-9205-1b2faca55d27', 1, 20, b'1', '36aa72da-8ce1-4461-91c9-499cf92ca4c6', NULL),
('725641be-583c-4e2f-8a85-c424dffcbb38', NULL, 'reset-otp', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '792fc235-35f9-4b64-bd47-4dc5cda1489b', 0, 20, b'0', NULL, NULL),
('72d07c17-d4b8-4034-b448-87a513e98b12', NULL, 'direct-grant-validate-username', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f83dbc35-cd12-48ec-b2dd-11fd277345b3', 0, 10, b'0', NULL, NULL),
('7a673853-30b4-4ed1-bf45-69a822f4ba06', NULL, 'reset-credential-email', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f03744cd-5a6e-4169-a4f1-a4303b83336e', 0, 20, b'0', NULL, NULL),
('7a7ce811-f415-48be-86f1-4b64dab82c47', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'f6397b7d-7159-4c5d-aa4b-1ac1403da318', 0, 20, b'1', 'ebe6df3a-2a12-409f-9163-5d278a07609e', NULL),
('7b9c3c4e-9c77-4414-80ed-fa092d75cace', NULL, 'auth-otp-form', 'ad3a9024-ffab-4299-a385-b777720941f3', '651d4dcc-27da-4920-a688-2d7cf37ef316', 0, 20, b'0', NULL, NULL),
('7d03a3f1-27d0-44b7-bf00-a56f2ac0ac77', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', '43a89e5f-3fed-4871-a091-980ccfa7ef17', 2, 20, b'1', 'a9114141-41b8-423d-8d43-1bc87e8aa5b0', NULL),
('7e4b980b-4dc7-4031-8bd8-f77f37c4331c', NULL, 'registration-user-creation', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '039ac1b6-c183-4339-8362-e91e7b0d0000', 0, 20, b'0', NULL, NULL),
('7ecae31c-846d-44d5-8565-2f9fb83770c4', NULL, 'reset-password', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f03744cd-5a6e-4169-a4f1-a4303b83336e', 0, 30, b'0', NULL, NULL),
('80a4f479-d737-486f-b8b8-b0a270aabaa0', NULL, 'client-jwt', 'ad3a9024-ffab-4299-a385-b777720941f3', 'e6a5cece-1c9b-4093-956b-0edb43f740b9', 2, 20, b'0', NULL, NULL),
('81c264d4-e2f1-43cc-8c70-0db4af429cc1', NULL, 'conditional-user-configured', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '36aa72da-8ce1-4461-91c9-499cf92ca4c6', 0, 10, b'0', NULL, NULL),
('835cdfdc-79ad-4af9-a48a-e7c16567b4ac', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', 'f03744cd-5a6e-4169-a4f1-a4303b83336e', 1, 40, b'1', '47fbfe33-c722-4b50-83f0-95bf2b91683d', NULL),
('88186b7e-8347-4701-aeba-d26bde5ed805', NULL, 'client-secret-jwt', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '020df459-1d47-4349-99f9-0cb7301cbe50', 2, 30, b'0', NULL, NULL),
('8dcb6db0-9885-4874-b66c-14bdc5c9957c', NULL, 'auth-otp-form', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5e2ec2c9-34d9-4435-b2e6-fb63a580e66d', 0, 20, b'0', NULL, NULL),
('8df16c62-fcb5-48a5-93f1-56f1655bbb74', NULL, 'client-secret', 'ad3a9024-ffab-4299-a385-b777720941f3', 'e6a5cece-1c9b-4093-956b-0edb43f740b9', 2, 10, b'0', NULL, NULL),
('927ef2d7-9d6c-43e6-9ac6-8880a22f5f4b', NULL, 'idp-username-password-form', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5d9140c5-70ca-4d10-b1cc-350134d3016b', 0, 10, b'0', NULL, NULL),
('96fee8b9-b6ff-42c8-89a3-2f80cb11797e', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'bb302fba-83b1-493e-b77f-bbe6c40f8cf9', 0, 20, b'1', '5d9140c5-70ca-4d10-b1cc-350134d3016b', NULL),
('9f1a0a3e-f53c-4290-899e-0c88bcd82c91', NULL, 'auth-otp-form', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '36aa72da-8ce1-4461-91c9-499cf92ca4c6', 0, 20, b'0', NULL, NULL),
('a3260766-d57b-42dd-8464-8c794f4efbb9', NULL, 'idp-create-user-if-unique', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'f6397b7d-7159-4c5d-aa4b-1ac1403da318', 3, 10, b'0', NULL, NULL),
('a32d1edd-9a8a-4f70-9dd1-7bb1329707d1', NULL, 'registration-recaptcha-action', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '039ac1b6-c183-4339-8362-e91e7b0d0000', 3, 60, b'0', NULL, NULL),
('a4dd9fed-c8b3-4801-9be4-c0b97b3be6af', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '00f7c37a-0aa6-4910-b323-99ce02cc6585', 1, 40, b'1', '792fc235-35f9-4b64-bd47-4dc5cda1489b', NULL),
('a80027ca-76a2-487b-bb7f-4d3ea9764e94', NULL, 'idp-auto-link', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'd02ee3fb-2855-4b38-b754-85604f3f7ba6', 0, 1, b'0', NULL, NULL),
('a9af7e52-4451-4d0e-b83d-bb67ce87f0ab', NULL, 'conditional-user-configured', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5e2ec2c9-34d9-4435-b2e6-fb63a580e66d', 0, 10, b'0', NULL, NULL),
('abb4c7b8-e84f-4228-9d9e-b71553d4c888', NULL, 'registration-recaptcha-action', 'ad3a9024-ffab-4299-a385-b777720941f3', 'd59742d4-6b67-4c38-9975-23058c5a8edd', 3, 60, b'0', NULL, NULL),
('abd2b60a-fce6-4cb7-8742-5cad9e940f8a', NULL, 'direct-grant-validate-username', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '66c90ce5-99dd-4cfe-84b9-23aa0257a9cb', 0, 10, b'0', NULL, NULL),
('b28badce-ce25-41e2-bacf-b37bf163cb24', NULL, 'identity-provider-redirector', 'ad3a9024-ffab-4299-a385-b777720941f3', '60620ae7-7fb4-422a-9a49-8ea356674734', 2, 25, b'0', NULL, NULL),
('b851f2ae-aeb5-4080-b96f-95938706c121', NULL, 'auth-cookie', 'ad3a9024-ffab-4299-a385-b777720941f3', '60620ae7-7fb4-422a-9a49-8ea356674734', 2, 10, b'0', NULL, NULL),
('ba454b0e-9fb7-4f23-ae5d-f6dfa5c911c6', NULL, 'auth-cookie', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '19f228f3-6ce7-4ac0-93e1-4381219fc7e8', 2, 10, b'0', NULL, NULL),
('bc3fb2be-1162-4e0b-89db-9ec7f836ddbc', NULL, 'no-cookie-redirect', 'ad3a9024-ffab-4299-a385-b777720941f3', 'e2a28be2-5dc2-41a9-9910-d4cf7f3c2238', 0, 10, b'0', NULL, NULL),
('c03b9a69-82fa-4fb8-9340-f47cd99082de', NULL, 'conditional-user-configured', 'ad3a9024-ffab-4299-a385-b777720941f3', '70ebdac4-13be-4b05-89bf-915979b72ee7', 0, 10, b'0', NULL, NULL),
('c1c0abff-8a48-48a3-bf71-bc6a8e6ec664', NULL, 'auth-spnego', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'fbb62cf2-9cfc-4b29-b450-b6e20cce8ce2', 3, 30, b'0', NULL, NULL),
('c52497ef-cbf7-477b-acea-38d234d46907', NULL, 'idp-detect-existing-broker-user', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'd02ee3fb-2855-4b38-b754-85604f3f7ba6', 0, 0, b'0', NULL, NULL),
('c7f06b16-1463-4092-a7b2-41c8fcec354e', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', 'a9114141-41b8-423d-8d43-1bc87e8aa5b0', 1, 20, b'1', '651d4dcc-27da-4920-a688-2d7cf37ef316', NULL),
('c99d76f8-2fca-4bd4-a0e8-717468d3afb3', NULL, 'auth-spnego', 'ad3a9024-ffab-4299-a385-b777720941f3', '60620ae7-7fb4-422a-9a49-8ea356674734', 3, 20, b'0', NULL, NULL),
('cc3b73b0-3461-4b4e-ad15-d08c4033a7cb', NULL, 'registration-profile-action', 'ad3a9024-ffab-4299-a385-b777720941f3', 'd59742d4-6b67-4c38-9975-23058c5a8edd', 0, 40, b'0', NULL, NULL),
('d15041e6-3a6f-422a-b25b-719171b02e82', NULL, 'reset-otp', 'ad3a9024-ffab-4299-a385-b777720941f3', '47fbfe33-c722-4b50-83f0-95bf2b91683d', 0, 20, b'0', NULL, NULL),
('d61e4c92-0ab0-48ad-8d75-742dd5ed82fd', NULL, 'registration-page-form', 'ad3a9024-ffab-4299-a385-b777720941f3', '8552568a-ae87-494a-82d5-8642deb289c1', 0, 10, b'1', 'd59742d4-6b67-4c38-9975-23058c5a8edd', NULL),
('dba7efd8-e4e2-408c-8943-c15589e7d185', NULL, 'http-basic-authenticator', 'ad3a9024-ffab-4299-a385-b777720941f3', '15b42694-c96c-4ae6-bdb9-3162c2f06e7b', 0, 10, b'0', NULL, NULL),
('dd3c90e0-8911-4838-a669-82f567741fa6', NULL, 'reset-password', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '00f7c37a-0aa6-4910-b323-99ce02cc6585', 0, 30, b'0', NULL, NULL),
('ddfde20a-f7aa-471f-91aa-89ad8b1e8840', NULL, 'auth-username-password-form', 'ad3a9024-ffab-4299-a385-b777720941f3', '41f703c6-402f-42fd-846f-1bd5a22bbfeb', 0, 10, b'0', NULL, NULL),
('de232ff9-dab2-4c44-be80-747f5b25bf03', NULL, 'auth-otp-form', 'ad3a9024-ffab-4299-a385-b777720941f3', 'f64821e1-5c2d-49d8-9e75-ef6533f930aa', 0, 20, b'0', NULL, NULL),
('df3e4166-8d03-4c50-a8f9-b45c4955c415', NULL, 'conditional-user-configured', 'ad3a9024-ffab-4299-a385-b777720941f3', '47fbfe33-c722-4b50-83f0-95bf2b91683d', 0, 10, b'0', NULL, NULL),
('e54ca441-d5fd-4114-b359-10cf85bb2db1', NULL, 'basic-auth', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'fbb62cf2-9cfc-4b29-b450-b6e20cce8ce2', 0, 10, b'0', NULL, NULL),
('e75b6131-3dc3-462e-aa75-4cf958f2725b', NULL, 'conditional-user-configured', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '792fc235-35f9-4b64-bd47-4dc5cda1489b', 0, 10, b'0', NULL, NULL),
('eaefbc99-4231-4eb0-bbfd-5d5af52fdb48', NULL, 'client-secret-jwt', 'ad3a9024-ffab-4299-a385-b777720941f3', 'e6a5cece-1c9b-4093-956b-0edb43f740b9', 2, 30, b'0', NULL, NULL),
('ed1ab77e-30d1-44c7-848d-6e03494e0690', NULL, NULL, 'ad3a9024-ffab-4299-a385-b777720941f3', 'e2a28be2-5dc2-41a9-9910-d4cf7f3c2238', 0, 20, b'1', '06b1f5c1-52b9-4b0b-8e66-926985b210db', NULL),
('f20634eb-1425-48a1-adee-f6bcd4ce0a2c', NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5d9140c5-70ca-4d10-b1cc-350134d3016b', 2, 20, b'1', '5e2ec2c9-34d9-4435-b2e6-fb63a580e66d', NULL),
('f3c4e833-28b1-4aab-be52-efdbaa9fd1ce', NULL, 'idp-confirm-link', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ebe6df3a-2a12-409f-9163-5d278a07609e', 0, 10, b'0', NULL, NULL),
('f8277eaa-eb6d-41ee-9563-85fc90ad1bd2', NULL, 'basic-auth-otp', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'fbb62cf2-9cfc-4b29-b450-b6e20cce8ce2', 3, 20, b'0', NULL, NULL),
('f97ae42b-cff4-4b22-8785-c22d2db4beab', NULL, 'idp-email-verification', 'ad3a9024-ffab-4299-a385-b777720941f3', '43a89e5f-3fed-4871-a091-980ccfa7ef17', 2, 10, b'0', NULL, NULL),
('f99ce7bd-442e-49ed-bcd4-efc69df1c74e', NULL, 'client-x509', 'ad3a9024-ffab-4299-a385-b777720941f3', 'e6a5cece-1c9b-4093-956b-0edb43f740b9', 2, 40, b'0', NULL, NULL),
('fa19c949-aa38-49d8-baff-8537d149a465', NULL, 'registration-profile-action', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '039ac1b6-c183-4339-8362-e91e7b0d0000', 0, 40, b'0', NULL, NULL),
('fa32cd16-f57d-42f7-8891-4b0b83e4d9da', NULL, 'reset-credential-email', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '00f7c37a-0aa6-4910-b323-99ce02cc6585', 0, 20, b'0', NULL, NULL),
('fb0b2dfa-6cfd-46e4-a930-28cae12aa797', NULL, 'docker-http-basic-authenticator', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ffc73324-12f5-4817-8c69-0b6aa319d2c2', 0, 10, b'0', NULL, NULL),
('fb511c73-de45-4c8e-aaf3-1c80038e168b', NULL, 'idp-review-profile', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'dffe8420-9527-4f36-982f-abf4450a4149', 0, 10, b'0', NULL, '537914a7-a6a1-4b48-8897-8d0481b82e73');

-- --------------------------------------------------------

--
-- Table structure for table `AUTHENTICATION_FLOW`
--

CREATE TABLE `AUTHENTICATION_FLOW` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) NOT NULL DEFAULT 'basic-flow',
  `TOP_LEVEL` bit(1) NOT NULL DEFAULT b'0',
  `BUILT_IN` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AUTHENTICATION_FLOW`
--

INSERT INTO `AUTHENTICATION_FLOW` (`ID`, `ALIAS`, `DESCRIPTION`, `REALM_ID`, `PROVIDER_ID`, `TOP_LEVEL`, `BUILT_IN`) VALUES
('00f7c37a-0aa6-4910-b323-99ce02cc6585', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('020df459-1d47-4349-99f9-0cb7301cbe50', 'clients', 'Base authentication for clients', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'client-flow', b'1', b'1'),
('039ac1b6-c183-4339-8362-e91e7b0d0000', 'registration form', 'registration form', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'form-flow', b'0', b'1'),
('06b1f5c1-52b9-4b0b-8e66-926985b210db', 'Authentication Options', 'Authentication options.', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('0cb851a2-a518-4db7-86b3-94dcdbd89c70', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('15b42694-c96c-4ae6-bdb9-3162c2f06e7b', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('19f228f3-6ce7-4ac0-93e1-4381219fc7e8', 'browser', 'browser based authentication', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('36aa72da-8ce1-4461-91c9-499cf92ca4c6', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('41f703c6-402f-42fd-846f-1bd5a22bbfeb', 'forms', 'Username, password, otp and other auth forms.', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('42e1d6f4-c416-49af-8aac-7031fea47450', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('43a89e5f-3fed-4871-a091-980ccfa7ef17', 'Account verification options', 'Method with which to verity the existing account', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('47fbfe33-c722-4b50-83f0-95bf2b91683d', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('5d9140c5-70ca-4d10-b1cc-350134d3016b', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('5e2ec2c9-34d9-4435-b2e6-fb63a580e66d', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('60620ae7-7fb4-422a-9a49-8ea356674734', 'browser', 'browser based authentication', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('651d4dcc-27da-4920-a688-2d7cf37ef316', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('66c90ce5-99dd-4cfe-84b9-23aa0257a9cb', 'direct grant', 'OpenID Connect Resource Owner Grant', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('6b26c06e-4f90-4a3d-8db4-f83f6bb7f71c', 'registration', 'registration flow', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('6f11ed35-967b-4132-ba1a-8c26f5517a30', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('70ebdac4-13be-4b05-89bf-915979b72ee7', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('72f5bf46-c8e7-4422-b275-8b1a444aec59', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('792fc235-35f9-4b64-bd47-4dc5cda1489b', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('8552568a-ae87-494a-82d5-8642deb289c1', 'registration', 'registration flow', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('a4ce7cb2-f6b1-4dea-9198-5be9742e0b88', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('a9114141-41b8-423d-8d43-1bc87e8aa5b0', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('bb302fba-83b1-493e-b77f-bbe6c40f8cf9', 'Account verification options', 'Method with which to verity the existing account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('ce45a0ad-ff74-4701-9205-1b2faca55d27', 'forms', 'Username, password, otp and other auth forms.', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('d02ee3fb-2855-4b38-b754-85604f3f7ba6', 'custom dms flow', 'have these users able to link these\nexisting acounts google accounts without also being forced to allow any\nrandom google user from being able to create an account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'0'),
('d59742d4-6b67-4c38-9975-23058c5a8edd', 'registration form', 'registration form', 'ad3a9024-ffab-4299-a385-b777720941f3', 'form-flow', b'0', b'1'),
('d8ced537-5101-4de8-aaba-d4476d1fb38a', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('dffe8420-9527-4f36-982f-abf4450a4149', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1'),
('e2a28be2-5dc2-41a9-9910-d4cf7f3c2238', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('e6a5cece-1c9b-4093-956b-0edb43f740b9', 'clients', 'Base authentication for clients', 'ad3a9024-ffab-4299-a385-b777720941f3', 'client-flow', b'1', b'1'),
('eba4ebff-04f9-42e7-b372-24aca87d5ec4', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('ebe6df3a-2a12-409f-9163-5d278a07609e', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('f03744cd-5a6e-4169-a4f1-a4303b83336e', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('f6397b7d-7159-4c5d-aa4b-1ac1403da318', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('f64821e1-5c2d-49d8-9e75-ef6533f930aa', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'0', b'1'),
('f83dbc35-cd12-48ec-b2dd-11fd277345b3', 'direct grant', 'OpenID Connect Resource Owner Grant', 'ad3a9024-ffab-4299-a385-b777720941f3', 'basic-flow', b'1', b'1'),
('fbb62cf2-9cfc-4b29-b450-b6e20cce8ce2', 'Authentication Options', 'Authentication options.', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'0', b'1'),
('ffc73324-12f5-4817-8c69-0b6aa319d2c2', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'basic-flow', b'1', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `AUTHENTICATOR_CONFIG`
--

CREATE TABLE `AUTHENTICATOR_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG`
--

INSERT INTO `AUTHENTICATOR_CONFIG` (`ID`, `ALIAS`, `REALM_ID`) VALUES
('537914a7-a6a1-4b48-8897-8d0481b82e73', 'review profile config', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf'),
('5bc05047-593c-466a-af19-3d43ba4268e4', 'create unique user config', 'ad3a9024-ffab-4299-a385-b777720941f3'),
('95ca9527-dbe1-4a48-a068-ab07ac329167', 'review profile config', 'ad3a9024-ffab-4299-a385-b777720941f3');

-- --------------------------------------------------------

--
-- Table structure for table `AUTHENTICATOR_CONFIG_ENTRY`
--

CREATE TABLE `AUTHENTICATOR_CONFIG_ENTRY` (
  `AUTHENTICATOR_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG_ENTRY`
--

INSERT INTO `AUTHENTICATOR_CONFIG_ENTRY` (`AUTHENTICATOR_ID`, `VALUE`, `NAME`) VALUES
('537914a7-a6a1-4b48-8897-8d0481b82e73', 'missing', 'update.profile.on.first.login'),
('5bc05047-593c-466a-af19-3d43ba4268e4', 'false', 'require.password.update.after.registration'),
('95ca9527-dbe1-4a48-a068-ab07ac329167', 'missing', 'update.profile.on.first.login');

-- --------------------------------------------------------

--
-- Table structure for table `BROKER_LINK`
--

CREATE TABLE `BROKER_LINK` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  `BROKER_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FULL_SCOPE_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) DEFAULT NULL,
  `PUBLIC_CLIENT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` varchar(255) DEFAULT NULL,
  `BASE_URL` varchar(255) DEFAULT NULL,
  `BEARER_ONLY` bit(1) NOT NULL DEFAULT b'0',
  `MANAGEMENT_URL` varchar(255) DEFAULT NULL,
  `SURROGATE_AUTH_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  `NODE_REREG_TIMEOUT` int(11) DEFAULT '0',
  `FRONTCHANNEL_LOGOUT` bit(1) NOT NULL DEFAULT b'0',
  `CONSENT_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `SERVICE_ACCOUNTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_AUTHENTICATOR_TYPE` varchar(255) DEFAULT NULL,
  `ROOT_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REGISTRATION_TOKEN` varchar(255) DEFAULT NULL,
  `STANDARD_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'1',
  `IMPLICIT_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DIRECT_ACCESS_GRANTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ALWAYS_DISPLAY_IN_CONSOLE` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT`
--

INSERT INTO `CLIENT` (`ID`, `ENABLED`, `FULL_SCOPE_ALLOWED`, `CLIENT_ID`, `NOT_BEFORE`, `PUBLIC_CLIENT`, `SECRET`, `BASE_URL`, `BEARER_ONLY`, `MANAGEMENT_URL`, `SURROGATE_AUTH_REQUIRED`, `REALM_ID`, `PROTOCOL`, `NODE_REREG_TIMEOUT`, `FRONTCHANNEL_LOGOUT`, `CONSENT_REQUIRED`, `NAME`, `SERVICE_ACCOUNTS_ENABLED`, `CLIENT_AUTHENTICATOR_TYPE`, `ROOT_URL`, `DESCRIPTION`, `REGISTRATION_TOKEN`, `STANDARD_FLOW_ENABLED`, `IMPLICIT_FLOW_ENABLED`, `DIRECT_ACCESS_GRANTS_ENABLED`, `ALWAYS_DISPLAY_IN_CONSOLE`) VALUES
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', b'1', b'0', 'admin-cli', 0, b'1', NULL, NULL, b'0', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', 'openid-connect', 0, b'0', b'0', '${client_admin-cli}', b'0', 'client-secret', NULL, NULL, NULL, b'0', b'0', b'1', b'0'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', b'0', 'realm-management', 0, b'0', '**********', NULL, b'0', NULL, b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', 0, b'0', b'0', '${client_realm-management}', b'1', 'client-secret', NULL, NULL, NULL, b'1', b'0', b'0', b'0'),
('40b87195-caf9-4928-89c6-ade363ef452e', b'1', b'0', 'demo-realm', 0, b'0', NULL, NULL, b'1', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, 0, b'0', b'0', 'demo Realm', b'0', 'client-secret', NULL, NULL, NULL, b'1', b'0', b'0', b'0'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', b'1', b'0', 'broker', 0, b'0', NULL, NULL, b'1', NULL, b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', 0, b'0', b'0', '${client_broker}', b'0', 'client-secret', NULL, NULL, NULL, b'1', b'0', b'0', b'0'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', b'1', b'0', 'security-admin-console', 0, b'1', NULL, '/admin/demo/console/', b'0', NULL, b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', 0, b'0', b'0', '${client_security-admin-console}', b'0', 'client-secret', '${authAdminUrl}', NULL, NULL, b'1', b'0', b'0', b'0'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', b'1', b'0', 'account-console', 0, b'1', NULL, '/realms/demo/account/', b'0', NULL, b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', 0, b'0', b'0', '${client_account-console}', b'0', 'client-secret', '${authBaseUrl}', NULL, NULL, b'1', b'0', b'0', b'0'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', b'1', b'0', 'broker', 0, b'0', NULL, NULL, b'1', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', 'openid-connect', 0, b'0', b'0', '${client_broker}', b'0', 'client-secret', NULL, NULL, NULL, b'1', b'0', b'0', b'0'),
('67d45f4e-c19e-41a4-861a-43479d57f913', b'1', b'1', 'auction', 0, b'0', '**********', 'http://localhost:3001/', b'0', '', b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', -1, b'1', b'0', 'Auction ', b'0', 'client-secret', 'http://localhost:3001/', '', NULL, b'1', b'0', b'1', b'0'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', b'1', b'1', 'dms', 0, b'0', '2bPh9oKUoLXu3XCOHb4klRwB9RVXFArT', 'http://127.0.0.1:3002/', b'0', '', b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', -1, b'1', b'0', 'Document Management System', b'1', 'client-secret', 'http://127.0.0.1:3002/', '', NULL, b'1', b'0', b'1', b'0'),
('77a90979-ac34-4353-9700-11005d688749', b'1', b'0', 'security-admin-console', 0, b'1', NULL, '/admin/master/console/', b'0', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', 'openid-connect', 0, b'0', b'0', '${client_security-admin-console}', b'0', 'client-secret', '${authAdminUrl}', NULL, NULL, b'1', b'0', b'0', b'0'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', b'0', 'master-realm', 0, b'0', NULL, NULL, b'1', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, 0, b'0', b'0', 'master Realm', b'0', 'client-secret', NULL, NULL, NULL, b'1', b'0', b'0', b'0'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', b'1', b'1', 'wallet', 0, b'0', '185ojGSt7UA60BPD9xXftHdMhXLOULqq', 'http://127.0.0.1:3000/', b'0', '', b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', -1, b'1', b'0', 'Wallet Management', b'0', 'client-secret', 'http://127.0.0.1:3000/', '', NULL, b'1', b'0', b'1', b'0'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', b'1', b'0', 'account-console', 0, b'1', NULL, '/realms/master/account/', b'0', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', 'openid-connect', 0, b'0', b'0', '${client_account-console}', b'0', 'client-secret', '${authBaseUrl}', NULL, NULL, b'1', b'0', b'0', b'0'),
('aaef7869-4756-4677-ad53-16a60aadc460', b'1', b'0', 'account', 0, b'1', NULL, '/realms/demo/account/', b'0', NULL, b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', 0, b'0', b'0', '${client_account}', b'0', 'client-secret', '${authBaseUrl}', NULL, NULL, b'1', b'0', b'0', b'0'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', b'1', b'0', 'admin-cli', 0, b'1', NULL, NULL, b'0', NULL, b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'openid-connect', 0, b'0', b'0', '${client_admin-cli}', b'0', 'client-secret', NULL, NULL, NULL, b'0', b'0', b'1', b'0'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', b'0', 'account', 0, b'1', NULL, '/realms/master/account/', b'0', NULL, b'0', 'ad3a9024-ffab-4299-a385-b777720941f3', 'openid-connect', 0, b'0', b'0', '${client_account}', b'0', 'client-secret', '${authBaseUrl}', NULL, NULL, b'1', b'0', b'0', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_ATTRIBUTES`
--

CREATE TABLE `CLIENT_ATTRIBUTES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(4000) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT_ATTRIBUTES`
--

INSERT INTO `CLIENT_ATTRIBUTES` (`CLIENT_ID`, `VALUE`, `NAME`) VALUES
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '1672816923', 'client.secret.creation.time'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '+', 'post.logout.redirect.uris'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '+', 'post.logout.redirect.uris'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', 'S256', 'pkce.code.challenge.method'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '+', 'post.logout.redirect.uris'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', 'S256', 'pkce.code.challenge.method'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '+', 'post.logout.redirect.uris'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '60', 'access.token.lifespan'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '{}', 'acr.loa.map'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'backchannel.logout.revoke.offline.tokens'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'true', 'backchannel.logout.session.required'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '1669177813', 'client.secret.creation.time'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'client_credentials.use_refresh_token'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'display.on.consent.screen'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'oauth2.device.authorization.grant.enabled'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'oidc.ciba.grant.enabled'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'http://localhost:3001/home', 'post.logout.redirect.uris'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'require.pushed.authorization.requests'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'tls-client-certificate-bound-access-tokens'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'false', 'token.response.type.bearer.lower-case'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'true', 'use.refresh.tokens'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '10800', 'access.token.lifespan'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '{}', 'acr.loa.map'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'backchannel.logout.revoke.offline.tokens'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'true', 'backchannel.logout.session.required'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '1673429764', 'client.secret.creation.time'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'client_credentials.use_refresh_token'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'display.on.consent.screen'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'oauth2.device.authorization.grant.enabled'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'oidc.ciba.grant.enabled'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'http://127.0.0.1:3002/home', 'post.logout.redirect.uris'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'require.pushed.authorization.requests'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'tls-client-certificate-bound-access-tokens'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'token.response.type.bearer.lower-case'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'false', 'use.jwks.url'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'true', 'use.refresh.tokens'),
('77a90979-ac34-4353-9700-11005d688749', 'S256', 'pkce.code.challenge.method'),
('77a90979-ac34-4353-9700-11005d688749', '+', 'post.logout.redirect.uris'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '10800', 'access.token.lifespan'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '{}', 'acr.loa.map'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'backchannel.logout.revoke.offline.tokens'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'true', 'backchannel.logout.session.required'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '1673429912', 'client.secret.creation.time'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'client_credentials.use_refresh_token'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'display.on.consent.screen'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'oauth2.device.authorization.grant.enabled'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'oidc.ciba.grant.enabled'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'http://127.0.0.1:3000/home', 'post.logout.redirect.uris'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'require.pushed.authorization.requests'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'tls-client-certificate-bound-access-tokens'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'false', 'token.response.type.bearer.lower-case'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'true', 'use.refresh.tokens'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'S256', 'pkce.code.challenge.method'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', '+', 'post.logout.redirect.uris'),
('aaef7869-4756-4677-ad53-16a60aadc460', '+', 'post.logout.redirect.uris'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '+', 'post.logout.redirect.uris'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', '+', 'post.logout.redirect.uris');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_AUTH_FLOW_BINDINGS`
--

CREATE TABLE `CLIENT_AUTH_FLOW_BINDINGS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `BINDING_NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_INITIAL_ACCESS`
--

CREATE TABLE `CLIENT_INITIAL_ACCESS` (
  `ID` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `EXPIRATION` int(11) DEFAULT NULL,
  `COUNT` int(11) DEFAULT NULL,
  `REMAINING_COUNT` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_NODE_REGISTRATIONS`
--

CREATE TABLE `CLIENT_NODE_REGISTRATIONS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` int(11) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SCOPE`
--

CREATE TABLE `CLIENT_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT_SCOPE`
--

INSERT INTO `CLIENT_SCOPE` (`ID`, `NAME`, `REALM_ID`, `DESCRIPTION`, `PROTOCOL`) VALUES
('05fe0602-09d2-4228-82d8-db21503136cc', 'phone', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect built-in scope: phone', 'openid-connect'),
('188a7535-1c89-4ef2-ad72-39b06946040a', 'role_list', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'SAML role list', 'saml'),
('231a6440-2cf3-4020-a5be-1a209ab552ce', 'offline_access', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect built-in scope: offline_access', 'openid-connect'),
('3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', 'email', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect built-in scope: email', 'openid-connect'),
('3dabe931-8924-440e-866f-0d4b49827f15', 'profile', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect built-in scope: profile', 'openid-connect'),
('3f438c5b-9d88-48de-b8a9-aa2c5593a537', 'address', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect built-in scope: address', 'openid-connect'),
('564ae84e-8c5e-4757-ab97-5adf27c4e07b', 'offline_access', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect built-in scope: offline_access', 'openid-connect'),
('5c2f341c-df67-49c8-97e3-5aa5c5251844', 'microprofile-jwt', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'Microprofile - JWT built-in scope', 'openid-connect'),
('5e71f713-b69c-4e03-8afa-cb36811ebf6b', 'roles', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect scope for add user roles to the access token', 'openid-connect'),
('630d39e3-d099-4760-80b0-75b564e63a0a', 'address', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect built-in scope: address', 'openid-connect'),
('8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', 'microprofile-jwt', 'ad3a9024-ffab-4299-a385-b777720941f3', 'Microprofile - JWT built-in scope', 'openid-connect'),
('b931a622-74f5-4265-a072-c21e8b1d944f', 'acr', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect'),
('cca4f4a7-b3c2-45d4-8034-dfba20158d68', 'roles', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect scope for add user roles to the access token', 'openid-connect'),
('d9cf5761-0681-4a0f-8eb6-55c88a381ec7', 'acr', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect'),
('e2725a2c-9249-48bb-8702-3b01772a1c03', 'phone', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect built-in scope: phone', 'openid-connect'),
('eadfd131-108d-4761-9985-ff8091747d63', 'web-origins', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect'),
('ebbbe116-6db8-48f4-b252-f1304bfbe66d', 'web-origins', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect'),
('f1902095-2d1b-4614-a307-e3375d1126fe', 'profile', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect built-in scope: profile', 'openid-connect'),
('f24ebe98-3cf3-4e2d-a8ef-5b5f9e41e5e1', 'role_list', 'ad3a9024-ffab-4299-a385-b777720941f3', 'SAML role list', 'saml'),
('f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', 'email', 'ad3a9024-ffab-4299-a385-b777720941f3', 'OpenID Connect built-in scope: email', 'openid-connect');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SCOPE_ATTRIBUTES`
--

CREATE TABLE `CLIENT_SCOPE_ATTRIBUTES` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(2048) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT_SCOPE_ATTRIBUTES`
--

INSERT INTO `CLIENT_SCOPE_ATTRIBUTES` (`SCOPE_ID`, `VALUE`, `NAME`) VALUES
('05fe0602-09d2-4228-82d8-db21503136cc', '${phoneScopeConsentText}', 'consent.screen.text'),
('05fe0602-09d2-4228-82d8-db21503136cc', 'true', 'display.on.consent.screen'),
('05fe0602-09d2-4228-82d8-db21503136cc', 'true', 'include.in.token.scope'),
('188a7535-1c89-4ef2-ad72-39b06946040a', '${samlRoleListScopeConsentText}', 'consent.screen.text'),
('188a7535-1c89-4ef2-ad72-39b06946040a', 'true', 'display.on.consent.screen'),
('231a6440-2cf3-4020-a5be-1a209ab552ce', '${offlineAccessScopeConsentText}', 'consent.screen.text'),
('231a6440-2cf3-4020-a5be-1a209ab552ce', 'true', 'display.on.consent.screen'),
('3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', '${emailScopeConsentText}', 'consent.screen.text'),
('3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', 'true', 'display.on.consent.screen'),
('3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', 'true', 'include.in.token.scope'),
('3dabe931-8924-440e-866f-0d4b49827f15', '${profileScopeConsentText}', 'consent.screen.text'),
('3dabe931-8924-440e-866f-0d4b49827f15', 'true', 'display.on.consent.screen'),
('3dabe931-8924-440e-866f-0d4b49827f15', 'true', 'include.in.token.scope'),
('3f438c5b-9d88-48de-b8a9-aa2c5593a537', '${addressScopeConsentText}', 'consent.screen.text'),
('3f438c5b-9d88-48de-b8a9-aa2c5593a537', 'true', 'display.on.consent.screen'),
('3f438c5b-9d88-48de-b8a9-aa2c5593a537', 'true', 'include.in.token.scope'),
('564ae84e-8c5e-4757-ab97-5adf27c4e07b', '${offlineAccessScopeConsentText}', 'consent.screen.text'),
('564ae84e-8c5e-4757-ab97-5adf27c4e07b', 'true', 'display.on.consent.screen'),
('5c2f341c-df67-49c8-97e3-5aa5c5251844', 'false', 'display.on.consent.screen'),
('5c2f341c-df67-49c8-97e3-5aa5c5251844', 'true', 'include.in.token.scope'),
('5e71f713-b69c-4e03-8afa-cb36811ebf6b', '${rolesScopeConsentText}', 'consent.screen.text'),
('5e71f713-b69c-4e03-8afa-cb36811ebf6b', 'true', 'display.on.consent.screen'),
('5e71f713-b69c-4e03-8afa-cb36811ebf6b', 'false', 'include.in.token.scope'),
('630d39e3-d099-4760-80b0-75b564e63a0a', '${addressScopeConsentText}', 'consent.screen.text'),
('630d39e3-d099-4760-80b0-75b564e63a0a', 'true', 'display.on.consent.screen'),
('630d39e3-d099-4760-80b0-75b564e63a0a', 'true', 'include.in.token.scope'),
('8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', 'false', 'display.on.consent.screen'),
('8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', 'true', 'include.in.token.scope'),
('b931a622-74f5-4265-a072-c21e8b1d944f', 'false', 'display.on.consent.screen'),
('b931a622-74f5-4265-a072-c21e8b1d944f', 'false', 'include.in.token.scope'),
('cca4f4a7-b3c2-45d4-8034-dfba20158d68', '${rolesScopeConsentText}', 'consent.screen.text'),
('cca4f4a7-b3c2-45d4-8034-dfba20158d68', 'true', 'display.on.consent.screen'),
('cca4f4a7-b3c2-45d4-8034-dfba20158d68', 'false', 'include.in.token.scope'),
('d9cf5761-0681-4a0f-8eb6-55c88a381ec7', 'false', 'display.on.consent.screen'),
('d9cf5761-0681-4a0f-8eb6-55c88a381ec7', 'false', 'include.in.token.scope'),
('e2725a2c-9249-48bb-8702-3b01772a1c03', '${phoneScopeConsentText}', 'consent.screen.text'),
('e2725a2c-9249-48bb-8702-3b01772a1c03', 'true', 'display.on.consent.screen'),
('e2725a2c-9249-48bb-8702-3b01772a1c03', 'true', 'include.in.token.scope'),
('eadfd131-108d-4761-9985-ff8091747d63', '', 'consent.screen.text'),
('eadfd131-108d-4761-9985-ff8091747d63', 'false', 'display.on.consent.screen'),
('eadfd131-108d-4761-9985-ff8091747d63', 'false', 'include.in.token.scope'),
('ebbbe116-6db8-48f4-b252-f1304bfbe66d', '', 'consent.screen.text'),
('ebbbe116-6db8-48f4-b252-f1304bfbe66d', 'false', 'display.on.consent.screen'),
('ebbbe116-6db8-48f4-b252-f1304bfbe66d', 'false', 'include.in.token.scope'),
('f1902095-2d1b-4614-a307-e3375d1126fe', '${profileScopeConsentText}', 'consent.screen.text'),
('f1902095-2d1b-4614-a307-e3375d1126fe', 'true', 'display.on.consent.screen'),
('f1902095-2d1b-4614-a307-e3375d1126fe', 'true', 'include.in.token.scope'),
('f24ebe98-3cf3-4e2d-a8ef-5b5f9e41e5e1', '${samlRoleListScopeConsentText}', 'consent.screen.text'),
('f24ebe98-3cf3-4e2d-a8ef-5b5f9e41e5e1', 'true', 'display.on.consent.screen'),
('f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', '${emailScopeConsentText}', 'consent.screen.text'),
('f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', 'true', 'display.on.consent.screen'),
('f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', 'true', 'include.in.token.scope');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SCOPE_CLIENT`
--

CREATE TABLE `CLIENT_SCOPE_CLIENT` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `SCOPE_ID` varchar(255) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT_SCOPE_CLIENT`
--

INSERT INTO `CLIENT_SCOPE_CLIENT` (`CLIENT_ID`, `SCOPE_ID`, `DEFAULT_SCOPE`) VALUES
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('2221607a-5394-4f1d-b6bd-950a2ed9ccbc', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('343c7912-686d-4e6b-9c15-3ae53698ebfb', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('487b979b-2296-4208-a510-cd0ec0c60fd4', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('4acd89d8-9537-4d58-8486-df058afeaaeb', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('6130f0db-ad03-4ef9-a0e3-52b600fb658c', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('67d45f4e-c19e-41a4-861a-43479d57f913', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('77a90979-ac34-4353-9700-11005d688749', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('77a90979-ac34-4353-9700-11005d688749', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('77a90979-ac34-4353-9700-11005d688749', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('77a90979-ac34-4353-9700-11005d688749', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('77a90979-ac34-4353-9700-11005d688749', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('77a90979-ac34-4353-9700-11005d688749', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('77a90979-ac34-4353-9700-11005d688749', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('77a90979-ac34-4353-9700-11005d688749', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('77a90979-ac34-4353-9700-11005d688749', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('79b1f5f9-2227-4a36-ad90-22d1d8643de4', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1'),
('aaef7869-4756-4677-ad53-16a60aadc460', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('aaef7869-4756-4677-ad53-16a60aadc460', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('aaef7869-4756-4677-ad53-16a60aadc460', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('aaef7869-4756-4677-ad53-16a60aadc460', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('aaef7869-4756-4677-ad53-16a60aadc460', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('aaef7869-4756-4677-ad53-16a60aadc460', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('aaef7869-4756-4677-ad53-16a60aadc460', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('aaef7869-4756-4677-ad53-16a60aadc460', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('aaef7869-4756-4677-ad53-16a60aadc460', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('bb143c9e-24c5-45a9-ba15-2e6448f4613a', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SCOPE_ROLE_MAPPING`
--

CREATE TABLE `CLIENT_SCOPE_ROLE_MAPPING` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT_SCOPE_ROLE_MAPPING`
--

INSERT INTO `CLIENT_SCOPE_ROLE_MAPPING` (`SCOPE_ID`, `ROLE_ID`) VALUES
('231a6440-2cf3-4020-a5be-1a209ab552ce', 'ea446258-35b2-411f-9452-87d625c5abb6'),
('564ae84e-8c5e-4757-ab97-5adf27c4e07b', '78b9c701-a217-4105-a786-f15b6fdd5d2e');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SESSION`
--

CREATE TABLE `CLIENT_SESSION` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `REDIRECT_URI` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(36) DEFAULT NULL,
  `CURRENT_ACTION` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SESSION_AUTH_STATUS`
--

CREATE TABLE `CLIENT_SESSION_AUTH_STATUS` (
  `AUTHENTICATOR` varchar(36) NOT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SESSION_NOTE`
--

CREATE TABLE `CLIENT_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SESSION_PROT_MAPPER`
--

CREATE TABLE `CLIENT_SESSION_PROT_MAPPER` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_SESSION_ROLE`
--

CREATE TABLE `CLIENT_SESSION_ROLE` (
  `ROLE_ID` varchar(255) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_USER_SESSION_NOTE`
--

CREATE TABLE `CLIENT_USER_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(2048) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `COMPONENT`
--

CREATE TABLE `COMPONENT` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_TYPE` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COMPONENT`
--

INSERT INTO `COMPONENT` (`ID`, `NAME`, `PARENT_ID`, `PROVIDER_ID`, `PROVIDER_TYPE`, `REALM_ID`, `SUB_TYPE`) VALUES
('0996df0c-69a8-4f7e-9b0b-85eafc485179', 'Full Scope Disabled', 'ad3a9024-ffab-4299-a385-b777720941f3', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'anonymous'),
('0e849816-8818-4e55-8588-bd02750693b6', 'Allowed Protocol Mapper Types', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'anonymous'),
('1020bb1c-dc10-4826-a8c9-6c6fe3ae475b', 'rsa-generated', 'ad3a9024-ffab-4299-a385-b777720941f3', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL),
('10b46109-a94e-42de-9dfb-15782f753591', 'hmac-generated', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL),
('17d198bf-b585-4832-bcd9-32f10df8f57d', 'Consent Required', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'anonymous'),
('3229e051-5a42-4366-a53f-f29f8db68d34', 'Allowed Client Scopes', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'authenticated'),
('32b2da8d-7e52-4f44-a4e3-01bf7acd1b25', 'aes-generated', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL),
('58340c49-9f79-4663-8f76-04f627f54c0e', 'Consent Required', 'ad3a9024-ffab-4299-a385-b777720941f3', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'anonymous'),
('64cda433-922b-4c96-a97a-b37082af1cb3', 'Allowed Client Scopes', 'ad3a9024-ffab-4299-a385-b777720941f3', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'authenticated'),
('6abec5df-275c-4cb7-8dd0-078697bf9054', NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL),
('742d5f17-05ab-4458-a527-6cf1954fb870', 'Trusted Hosts', 'ad3a9024-ffab-4299-a385-b777720941f3', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'anonymous'),
('748bc5bf-6906-4c2a-bccb-061eea9da9f4', 'rsa-enc-generated', 'ad3a9024-ffab-4299-a385-b777720941f3', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL),
('782696d5-d622-47e0-bec9-de59bd326af5', 'Full Scope Disabled', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'anonymous'),
('7bc89f9a-be7d-489b-8c3a-0d447dd39396', 'Allowed Client Scopes', 'ad3a9024-ffab-4299-a385-b777720941f3', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'anonymous'),
('972d40d8-3b2b-4400-9bf6-34a2c12c06d0', 'Max Clients Limit', 'ad3a9024-ffab-4299-a385-b777720941f3', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'anonymous'),
('a41c2acb-9a34-41f6-94e8-54230bc3e9e9', 'Allowed Client Scopes', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'anonymous'),
('b1debe46-8310-4512-af85-f66b8ff37a0c', 'rsa-enc-generated', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL),
('b342b5f4-c513-44b3-8e36-cef438769212', 'aes-generated', 'ad3a9024-ffab-4299-a385-b777720941f3', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL),
('b3d6685b-05d6-4795-aef2-9850591cc247', 'rsa-generated', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL),
('c0692856-f68e-4098-a2db-0ce33f877681', 'Max Clients Limit', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'anonymous'),
('caf081ec-8922-4003-b18b-10e17eb302d9', 'Allowed Protocol Mapper Types', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'authenticated'),
('e11edd29-c7fd-49e4-b7ba-2a79076cb0fa', 'hmac-generated', 'ad3a9024-ffab-4299-a385-b777720941f3', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL),
('ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'Allowed Protocol Mapper Types', 'ad3a9024-ffab-4299-a385-b777720941f3', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'anonymous'),
('f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'Allowed Protocol Mapper Types', 'ad3a9024-ffab-4299-a385-b777720941f3', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'authenticated'),
('f8a08c27-cdfc-4049-bad9-c70053d7902a', 'Trusted Hosts', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'anonymous');

-- --------------------------------------------------------

--
-- Table structure for table `COMPONENT_CONFIG`
--

CREATE TABLE `COMPONENT_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `COMPONENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(4000) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COMPONENT_CONFIG`
--

INSERT INTO `COMPONENT_CONFIG` (`ID`, `COMPONENT_ID`, `NAME`, `VALUE`) VALUES
('01b8f0ec-9284-4762-bcad-567ea6009d78', 'f8a08c27-cdfc-4049-bad9-c70053d7902a', 'client-uris-must-match', 'true'),
('07335a72-c0dd-415d-a9ee-46c771275987', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper'),
('0bfe98d4-41f2-464c-82c6-8fc4a3a3f46e', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'saml-role-list-mapper'),
('117730e9-c97c-4197-b915-2beab1bb6b0f', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper'),
('17c843e5-b1ab-450d-9aea-858d15a29422', '64cda433-922b-4c96-a97a-b37082af1cb3', 'allow-default-scopes', 'true'),
('1c1c9bb9-9eb7-42f2-ae12-74f0be36d3c9', '1020bb1c-dc10-4826-a8c9-6c6fe3ae475b', 'keyUse', 'SIG'),
('22a66fc7-3e13-4572-b438-29da8571578b', 'b1debe46-8310-4512-af85-f66b8ff37a0c', 'algorithm', 'RSA-OAEP'),
('2bd3b2b9-08f4-429b-8f94-01bf46bdc7d1', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper'),
('2cf11cd1-ab55-4310-b54a-058872e342fc', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'saml-user-property-mapper'),
('4228409e-241f-46fb-bd98-a5944845a35d', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper'),
('427d96b2-b24f-443a-9389-caa1bf4744d2', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper'),
('48a58270-b817-4575-9772-32765e6bf03c', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper'),
('51635337-99fb-4038-b24c-2dcd9df10b4a', 'b342b5f4-c513-44b3-8e36-cef438769212', 'secret', 'jiP0zIV2e3F9NUyM3Fv-yA'),
('554afedb-f632-4453-9523-5e6fb9c93c0e', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'saml-user-property-mapper'),
('56fbd807-5bff-4356-a5dd-fba2e843b049', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper'),
('5921c006-0fb4-42ea-896d-37c960553c8c', 'e11edd29-c7fd-49e4-b7ba-2a79076cb0fa', 'priority', '100'),
('602ba92b-dae4-475a-9afa-f0fc1e267c3a', '10b46109-a94e-42de-9dfb-15782f753591', 'priority', '100'),
('64991a12-2014-4c99-83af-79b071316ca9', '972d40d8-3b2b-4400-9bf6-34a2c12c06d0', 'max-clients', '200'),
('68f5fd9c-fd3e-410e-9521-15eb24a01b01', '7bc89f9a-be7d-489b-8c3a-0d447dd39396', 'allow-default-scopes', 'true'),
('6d44d663-8b46-484f-b674-d6c95335dac0', '1020bb1c-dc10-4826-a8c9-6c6fe3ae475b', 'certificate', 'MIICmzCCAYMCBgGFmwsf/TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMTEwMDkzNjE1WhcNMzMwMTEwMDkzNzU1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDA4fP4D9tV+9M9xFvvWNN3Y6ZhltdoCfJKEa60qw6LjN2+8M9+V1qaEGhQPwt944XmCEXToK82zFfXiI57fDIPstsnl3COgoLMPo/0Exh7Bv4AVnoNLQzlTdKPjSTdk3MA0vsDFEG2Pa8GcXbfDhnK6SwIaj3QP4RtEiGc/IBKuv48ehUb4eVqAgGHoHSu+pUQZp6e7vDhQhDyr04345/7lZr2Q/j2GZdGJXphd91pa3M7l/ZXEftI1qYVrG8h3yDKoh4K31s+wl/Fo+ioS3L9aBOJBRPhYuWzXOwC9K4Y4XU6X/uB5OL9LImaP7TdKHqvz12hC8ISmBm7H9VqNPOLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAH4z1le1pkDhjwKjtWBZOH2ZzAcBYbYH8KaL7w2eA+dO3hr6/WRcx8S/I9ekxha/GQ3MpwWF9HkIYKD9wsAL+6LUIQgbrhPNbex8j0l3jYdqKleRvrwGwu4E7FXyufNe/PHlvKVZEMWocgukJanEj7M7y1FrsVAK958M58+OFRZ2c1mmVG5wceOf1VLc7D2KQlvCusNLplBg9Rpx6Y5qb9lBelRs1MzGe9yd9rOsOswXD6P0V73GVbxVUS76oUUSnqHUebiDO2GIy/XSnwH5IvWqt1beo14Qpl7U7JsNtCVWA43rn0eQcggLV/YrLvC/OAnQbwCXbpmZuIPptygxqMw='),
('6d6f1cd5-ee72-439a-bbc0-e1d238f9f148', '748bc5bf-6906-4c2a-bccb-061eea9da9f4', 'priority', '100'),
('6dd7fa85-82db-403c-b4ef-f0d444beb0df', '1020bb1c-dc10-4826-a8c9-6c6fe3ae475b', 'privateKey', 'MIIEowIBAAKCAQEAwOHz+A/bVfvTPcRb71jTd2OmYZbXaAnyShGutKsOi4zdvvDPfldamhBoUD8LfeOF5ghF06CvNsxX14iOe3wyD7LbJ5dwjoKCzD6P9BMYewb+AFZ6DS0M5U3Sj40k3ZNzANL7AxRBtj2vBnF23w4ZyuksCGo90D+EbRIhnPyASrr+PHoVG+HlagIBh6B0rvqVEGaenu7w4UIQ8q9ON+Of+5Wa9kP49hmXRiV6YXfdaWtzO5f2VxH7SNamFaxvId8gyqIeCt9bPsJfxaPoqEty/WgTiQUT4WLls1zsAvSuGOF1Ol/7geTi/SyJmj+03Sh6r89doQvCEpgZux/VajTziwIDAQABAoIBACn7xLfU88AGfVdvezdg1T6icR/CzoY1zAg1SxrGNPdJJScfkXqFlxH7ykjVQDIZqRaF7HUA/8JkviYK8kCMqvTh0HQQsY5DeCbu4zSUR3rX7cezCwP9L1ZmFxPp/AFCzAB86+giq574VDWJ0v8AObsB//Sg8211teRr0ucxytb49ZhAH9U9787tWXrMwVgCqi11qu+kntz25R3TLJ4URiPWKo0Wgfcr8v0TDgIfbth//fEOp+xCoLic1cHPAMuB2cLF3b+uBT+CAZMTzv1fvJD4gSrbqs9ATGBRW2cLbDfkk9zyUOkNzu3CQOsK40za+YL4OMzAHGXOEVYrm34eQCkCgYEA9LDvFs/9hSAY35DYtJdcEZlEu/PfHh7QgkM3IYPzxabhu94xQmzYmcSK/EghrKkqm3emv9d+nFt2Rv7q7TV+CAlkRXftUjmDWc++uciTHC1ZA7OU8duAuK00jd1fIf02/W0oo9BUPwPyIWsHF8mpYrSRfNbVVytDhyMpnKjpov0CgYEAycwLxcKJkX/II/08k43v6c8tpqIYxO48eLl6ZFlUVCV/xGdbiXq8sHasb+aGCPva3ZjTPk5t+L0Af0XCxVZf9hcDJzQkCL3n+800aeCM7cMQjIQlQAe64Xpqs4ba0HDb/EUOds4tDvCJ/EUMB430hp6giBC0xdsHa46F8IJhSycCgYEA5q3HOOJsRwyzZlDPe7EWAyFTQz3toh+6wpNLbjVPo45oUQxvtAeZS52Wya/Wz0fL+zUZ5tHpcs5m+xdnsqkzX7A676LYASRnSEwpqkwFJBM8T9kFGd2txGzFltiTzx9AsDowjf7g7Wdy5T5ZOXvMTFmerup5xevrhYMIv8AeQqECgYA+7AvjryQcJT7v0d+YltJvEjXG1pZomWxrrFH4hk4gKs0rHZtSQ94gG/Dqt3Oly3pUTHnZ3LS3sZ89EDCKPcOQRV6rU7vEqgpy3mpwdR8caA158x52V7Ky6evpbKxAAGDnyVSYQPOVy/UKnzEADghoDYA6zRLA+unWZMto0g6qUwKBgA8SiQt+GXK/mpt7HH4b10VW0Ow9bW74k19bA+UpzzJZL1h2V/wYsrwP1lqj1tZ2OUaVRtNH91rozHSHmt9FBA6r2fDKM2eaP6lw3CLpfkH6pnCCNF4Z4W/sJOt230+lJpETWAjoIHlRTJGDO6ocnMD6JJv7stm4cWTmFGXbozHq'),
('6f863716-dd1c-4827-88a2-4386bfd31c3e', '3229e051-5a42-4366-a53f-f29f8db68d34', 'allow-default-scopes', 'true'),
('72e05861-4c10-4d73-9c62-c0a6794d85b7', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper'),
('73d2fde9-8dc2-4f34-be59-0519c9aa5673', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper'),
('73e5b692-fcca-4ed4-bdec-e1539cad9033', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'saml-role-list-mapper'),
('7482ae17-9342-4f79-a2bc-975e51049382', 'b342b5f4-c513-44b3-8e36-cef438769212', 'priority', '100'),
('7be8705a-c532-4f40-8c43-49117f1386a0', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper'),
('7ef1ee2b-1d95-47ca-a678-df39cba1a0c7', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper'),
('7f2141d6-2629-46f9-8cc4-5691aaf8f311', 'b342b5f4-c513-44b3-8e36-cef438769212', 'kid', '1939abf2-fe78-434b-b74a-a3076479c17e'),
('8043eba1-65b2-46bc-a695-1bcd9128bff0', 'b3d6685b-05d6-4795-aef2-9850591cc247', 'privateKey', 'MIIEowIBAAKCAQEArbq7u9WVg/3OkM0Mw6IHsXvvbnrswi9jK6MzAW+bnHdj0tHeHH97oItOvqKznkKWDDdNAl0ZRAAI+8wq1YLHnAU8IcHvIgAz+rwafFiYSKly+OmAMRuKKb5OVrDKbFjb+XMWhN62ab0mZ7oaY3EsfFrgbt5EJGv2nmKbJs/LMcq0LBRi19a7zujzHKNK36Yy6lJyQFRYd6Oeg4yjKeC7qVyB4CHHJS41PPbh6NZc0K+9Z/78rqxBpzBM2McCPSqzmOxZ5y/MIX2XapjMyGO9UIiuUbs2SspSGkkrMkXXI80XkkNRG3uFvdmV8zFktnFEC2WHJ4uypdYpynVwVmeiiwIDAQABAoIBAEoUCsMAQt3iVrdlx+CPcapbh2/bmKMAo8/SqggduAPS4MzfUk9iiKufWzdslxyPlf2lgv/UBNb7ENmVaFpchpLfpJFcaYRdA80RclW9TUoGfxDmOBQ4gwRjsnHCtr3Wcg3+5gZIFQ4nan3mXCQ0+NwZwANmYTYKl0FYGIJHLoSPD3Lp93bRprOlMHTjb2XvPtK9HO8xHsHt0foE6P1ReRIlfh0xQbF3d+lb8ecflOv56zoK2qLyViq29k1Pckpii21qAi3uRAZiBlqMzhQx25IKq+OgojzxNGtIJ2ShjVOwjiJUcKDhcKvmZl5z/FbLD85Ascx0Cp59+QA5rGYCnZECgYEA39vEFb6hmWelI94XxBe/vECCQx68BwVYzVfaMb3pJDIRE+EgIgA65A4/J6U4463MYNvqP8JVAbS3060DOFk7PHi5rMZ2cFpPOSYa18dHtl75SIQsH0MO6RToBMPMfVCgrFlZ9dxhP/M1XLLMwfxFyqJVV4C3HQTNR0bH6Kn/fMkCgYEAxqxnZsA1dZvSWfm9JfAoAvrxOvSBOV8MlpkBX3SJmAA1I5Esb702JF6C26CX5NEltjIVhQQvz7CJ7LIqfEWjLOxaSqGDLCdssSGf1lfMmHSamh4rbidend2SAgc9qxauT+o0lfJAadFt1UyAIRgS9E879Mq3BZHb4dgEALDzUrMCgYAOcRshW/8I6orY2Ycm+3E/L9o3glAXE906wiQteVcFIsW/RpLQHrut4s1oPVyCM8Avr4BZRKw/Q+1oFo1SoU8VA6TW5KbXcLwTr8WjjhOuTEpAx2YhTi40E0k0pX0XyI/VDp6jIeiUO5iBtndHPIM0I2zmDEPD939WzdYvyGfXIQKBgQCLrlkAr/CmIIjzQ5fN3Zx0A/Soq5FTQdV66FZDw46dtL+nowDoCtLPHTfJrI4+jSGDiJECtV/cGNXP+a/PMbK4+e+9evLbj1hm7SoQrCgnpAuygbWtO7bVLRvjmy2rZUXm39Za+jh5bYpYJfIL0n45EKApyoCFRPigP50I02Av6wKBgGVoJdSW9NbkK7yTwR5aVSJIyv5H2bNnd2TjOe/XPz4eKY6KgOWPlluAQzn8iuFwN4UMnFsYLRR3hQrrfix2kGKlCMzEU27jzqEGkd5JfD6nbL/2ci8yg9DJV4yuJv14dW7TTOiP6B3UyYzL0j8Q05Zdn5sjXANPHn8jRVALsRHI'),
('805f54c6-79b8-406f-86ee-90aa45d5e1b3', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper'),
('81eef513-a52d-4bae-8a51-b15f2baf1580', '748bc5bf-6906-4c2a-bccb-061eea9da9f4', 'certificate', 'MIICmzCCAYMCBgGFmwsgqzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMTEwMDkzNjE1WhcNMzMwMTEwMDkzNzU1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDTLIon1jBNlmmFYje4qFSzOxj/UK6/gSa0G9VoaUV2bQIzQpb9ZqY60ZG2sTnDmDz5JJ5hx/a7P5ygRxc9iBT+ENDuRymSI+vHzK1en4uN921ctNlOccadKJ60ILB2WzgtlKzOhoWuHsy14uykkgNwOno2PhdYp2VsJWgudM7j61Zm26+fpIoOy5zlb29C+rrTOG6L0aBkLmkFci8Ds6ePqdXUc4lr81xLRTrzg8whodHUXuyEEtx7r33mTc0HzvU5nI7L1vuVqawf99D+NMvfBTCGsP9jQ8FFhgtGpNFtcFgVt7yQgYK6vPEssjAI1hTrmCKN0KI2VU9WdZ2cZ5TfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAARWYAaGHVnJVIX+USqvUjfYSvffYw5KYTBLuDhsjPGJGJ0UKzyzNfrmGaDGxd85k1UNVOMeIEO80EEqqIg+ECACHgmydCd4w3BvVXE16T6PtdlqW/cB61tih1AsdwXdBFCZ4aoBHMEJm4WzoFb8Uwh5duFk0HmXoKSjC1Rvzb1LV6ODEwDDxExJ3YL7BrGOLWCoB7rqyoJ0BOanvkSMdfVmL5ECDsCvenDZcjeEp5M3xOpp+/izZWTyANUeif4y7ilQ+/vPE6eId7aKkoBOm9fhKSk+vrmmwWLdamnfB+U+Wb6Npv6piF8uUL5p9aUzpXx2JEINixJsqqzucVd/EjA='),
('856531bc-d643-466d-bf4c-5749186f873b', '32b2da8d-7e52-4f44-a4e3-01bf7acd1b25', 'kid', '14ad9c0d-501d-41d2-824e-b1a1a19e83e4'),
('88fa8da7-5e51-4d0c-aecf-9ae1ab100113', 'b3d6685b-05d6-4795-aef2-9850591cc247', 'certificate', 'MIIClzCCAX8CBgGFmwsnfTANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARkZW1vMB4XDTIzMDExMDA5MzYxN1oXDTMzMDExMDA5Mzc1N1owDzENMAsGA1UEAwwEZGVtbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK26u7vVlYP9zpDNDMOiB7F772567MIvYyujMwFvm5x3Y9LR3hx/e6CLTr6is55Clgw3TQJdGUQACPvMKtWCx5wFPCHB7yIAM/q8GnxYmEipcvjpgDEbiim+TlawymxY2/lzFoTetmm9Jme6GmNxLHxa4G7eRCRr9p5imybPyzHKtCwUYtfWu87o8xyjSt+mMupSckBUWHejnoOMoyngu6lcgeAhxyUuNTz24ejWXNCvvWf+/K6sQacwTNjHAj0qs5jsWecvzCF9l2qYzMhjvVCIrlG7NkrKUhpJKzJF1yPNF5JDURt7hb3ZlfMxZLZxRAtlhyeLsqXWKcp1cFZnoosCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEATyPJulpguoLKulo10P949jTXbz4aB6/Exz6BpEHK7ifCLEhIf+iJAKsFRYX9/VqORyyeE7bDc2MqsRYVj52c+SKzlGSZ6BbioZBNFA8+7uyweAMbqd7Q4ttdQgWOb0dhzQQDo+T1RCtFwd8LVWVA+rMbygs8dunGvMp0h5TjdBWjzkZDc8kONAdBLhd9tgtg+Gyv87RhpcZaaGLDWbigcXXnNT1r66zcySNZTF11mpU7b7kCvGGP+IaVWSmFWt+iSR6vnHztivz2/RzOJcg/SkusKFKrNpAJgyG/MNfALkXtBGPe/1H/XN7iWVVbYkgfiiG7+MGPrT8sW4An7+C/LQ=='),
('8954b10b-1219-42e9-8ae9-f9e2eedf050b', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'oidc-address-mapper'),
('89c933fa-5ad1-4215-a504-e1ba03410dff', 'b3d6685b-05d6-4795-aef2-9850591cc247', 'priority', '100'),
('95c121a7-0032-494d-a90b-01b4f23333e6', '32b2da8d-7e52-4f44-a4e3-01bf7acd1b25', 'priority', '100'),
('980bfa8b-4e87-440e-a25d-69ab34296d79', '10b46109-a94e-42de-9dfb-15782f753591', 'algorithm', 'HS256'),
('9d13b4c4-fedc-45c3-a85a-34461c52a912', 'e11edd29-c7fd-49e4-b7ba-2a79076cb0fa', 'kid', '372d0c06-b61d-4048-93bd-7150b3fbeab8'),
('a1595d5e-5a47-4cf9-ac8b-188102cd53f8', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'oidc-address-mapper'),
('a18ca637-37ee-4dfc-b7e4-93db7e10ccf0', 'f8a08c27-cdfc-4049-bad9-c70053d7902a', 'host-sending-registration-request-must-match', 'true'),
('a46f2a35-9682-41f6-82e4-42b86c408a0b', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'saml-role-list-mapper'),
('a57f4750-802e-40f0-94dc-2cf50cdccaa7', '748bc5bf-6906-4c2a-bccb-061eea9da9f4', 'algorithm', 'RSA-OAEP'),
('a5fc2abc-9358-4aee-ab2e-d5b58e854419', 'b1debe46-8310-4512-af85-f66b8ff37a0c', 'certificate', 'MIIClzCCAX8CBgGFmwsnITANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARkZW1vMB4XDTIzMDExMDA5MzYxN1oXDTMzMDExMDA5Mzc1N1owDzENMAsGA1UEAwwEZGVtbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKeR5E0KCb6wDQPwy/Aaz/T9TeRp70sZvsVRPsRtQ+u9iYIVDWXdYGJBJD1fH4omb8quQc/MldakuPw0to7jkUsYqeF5cW2uMI3wx1+1kb1C+xbmNRn21Lp5Au32wrxEdHQlaCUts00mcdS/WjEkHQKrZw42Y0cV2s9MLfb/s10EefT/yIDkoDG1KIJFl7oW2LQqW/HJMZEdQOAdcRr/8b2UL9vhW+0H/woPNNXxk6HQk2eDmdwMLfNOY8Mx6bUdFQBi9LxJ3OvyPhgjaFZXen/DB1gfTst+7qKG+JSwpHVXl+aW2OZL1zndEJej5MOEEYzoDk6HrV9AHfxi7otB0EECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAbspIhvxfqHHq9NJQfbtlzca5DX6fH1qLEXMgxVOFY5UoCY/nlWA5tunuu2n+gABEOQu9RbaXjJ2v9Ns+XZ+H5pdpDFu1EL98H/4NvcBOMi5Y6ZBPFjG2VVxG653Gs2f+HPLqv3cdu206N9tZhyoFLqY2/+La0Gv+8XMmxolFsNcHur/UgTrUFqxIhSamHEvib5pHRbo44J+GsNktc5jctkVxnBaH1TnZlQhrGtdYz3KTWPj2uyYE+CZ8fLohCt+egVU2OT+q7z7SnP6chqSPEO//TRvmwBoWZbufPf2hA05HRmkERa70064OvTT61vExjw/UQSogJLDbYkcbhiLiag=='),
('aa64c4be-9a8c-4980-bd74-835e22143d48', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'oidc-address-mapper'),
('ab2684db-ec9b-430c-b024-95268dc6d3a2', '742d5f17-05ab-4458-a527-6cf1954fb870', 'client-uris-must-match', 'true'),
('ad0ef1bb-168b-4ffb-92c6-df6aa160e261', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper'),
('aef32b58-70a3-4db0-81ac-4ecbe86299e5', 'ebf64a64-7ae4-4d69-8641-6d0bcc8efa52', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper'),
('af58f9d5-2553-4661-9bfb-51a60b8e655f', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper'),
('b1c7dea1-4c61-4496-aa23-f3f8e318f0a1', 'c0692856-f68e-4098-a2db-0ce33f877681', 'max-clients', '200'),
('bb3c4823-062c-4546-b62a-b41e28f2cf48', 'e11edd29-c7fd-49e4-b7ba-2a79076cb0fa', 'secret', 'I_F5mlnoqj_HdPm-3noKIoqTfzIjG6XdqixNJntjq2NRUtDdyQr29dxwz3Ykcp5iwEjEZ6yEEfB4iu2DathsJg'),
('bc3ad89d-dcd0-4925-a290-30832187f7b4', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper'),
('c350b416-8bae-4ce7-826f-05e4b9ae8647', '748bc5bf-6906-4c2a-bccb-061eea9da9f4', 'privateKey', 'MIIEpAIBAAKCAQEA0yyKJ9YwTZZphWI3uKhUszsY/1Cuv4EmtBvVaGlFdm0CM0KW/WamOtGRtrE5w5g8+SSeYcf2uz+coEcXPYgU/hDQ7kcpkiPrx8ytXp+LjfdtXLTZTnHGnSietCCwdls4LZSszoaFrh7MteLspJIDcDp6Nj4XWKdlbCVoLnTO4+tWZtuvn6SKDsuc5W9vQvq60zhui9GgZC5pBXIvA7Onj6nV1HOJa/NcS0U684PMIaHR1F7shBLce6995k3NB871OZyOy9b7lamsH/fQ/jTL3wUwhrD/Y0PBRYYLRqTRbXBYFbe8kIGCurzxLLIwCNYU65gijdCiNlVPVnWdnGeU3wIDAQABAoIBADajLQG+oNPKSXYJ4gnkf7m53i9c9EG3TEjIdNBlgGPyM2II5iEdOIA6bd2bgCsTzh7WMyZwgu2SuVcc3a39chUES9KC1gYqRhx1YBv94rEyJfkZD6qEtJNACcPoO0/8LQ5aC9YJpzfUXznmQz0XTE1yy+ER8p9s/Ehda1WtwkPkzSvRQuC8E8htSuBdL0W5/IMRpEZhQkfKwPvWIeuhBvhYkFV+CFiz9fG9phxWmK9v/oUQ7Kjz1ANggwinSZKPdmT5jd2c9sKJst0nGcQcPMq03JkhP+d5SqrHicbLin9Q1BYsAe8WW60p7NsinMkSkGiK2KbXQe8cOmohY2rHqOUCgYEA65xHZGyqkSuoyYqKCUa4kTmPTA2G56/SOqHkCl+P6mStMOZ6xsnoyPBOKQBQ7F22y7kTh0/zJr1xOnIUUZnPzJStrDiQiVJ/uICXLxXTeoM6+G+sqQ81pVSeMlHb8rIr0BS49Igrwg9W5ko76XSOU297ia0ZhJVMfE+ILdsHQTMCgYEA5XLk7xEky77sdIDAhVJNb8uGdz4Y1Fy/wJdeMoEVh95Gtav7lgBXyhDCfOh59cjQgX1ac52xaI/VUJvjZJ6l0fxe7uhKoVf/vZsqcuvYT1QrwlhQ0/VcZRZOdsuImnKovAt4sRU/FlzDELBNGyvWn5EX5DI4ZB79do6qBKTZNaUCgYA7f52vyJlSS7o2Gxw8t3VIh0aeqBPXUlk+oT9bN0K6qG3sGWgL51U32SeDxyaoagoNbFF4LEJ1GAYOAl0LNlJ5kVpCUY5+fyztxNto8pQTLiyoLFtn3gVoGPRSNMXchg32YCVM605RlVoWkcyLafm/LDoATIxTJPjJs7PqEJPGbQKBgQDkZgNXqpQbMNlFe2ipDe1BbLJUfn7O3eiOuN6unWomTm/KpgERJxQ8c4R2PCAzNou/al2gmwefUxX/YL3xSi88IOELJjYr92H+hrexn+05wkqw8aK76xDnG1ZN0HsRazNlxHGGrOSYyQvvz99hPbkuK4tBv2/80hBydL7vUn1ZdQKBgQDAH/Dis/zCAFPJw6/ClHH+OUgJz6FQr0mtdd2YWZSmnK4veCzbyC39EQUlQXoWZLEmpG/zcrz00BTzBMtSiAQR/YWqYokmdxJzanzRMziiH92WRvwqX+MHVXBoKkVAmaRjpea7UDo0iBwdTr+SHoTpMg7KPchJfMp5fuAByeawRQ=='),
('c61dd17f-814d-473e-b5ca-3c03fe545f7b', 'b1debe46-8310-4512-af85-f66b8ff37a0c', 'priority', '100'),
('c9541c97-ffd7-4111-a5c0-be3b22f7ac1a', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper'),
('d0553bcf-de35-425b-aa98-d2e390248c1b', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper'),
('d47d2d7f-eba6-45df-98c7-4ceab4cd34c1', '1020bb1c-dc10-4826-a8c9-6c6fe3ae475b', 'priority', '100'),
('d64d2073-9895-427b-9b74-5781a06e06b3', '748bc5bf-6906-4c2a-bccb-061eea9da9f4', 'keyUse', 'ENC'),
('d97638cb-acc6-4764-a852-0aafb779e6dc', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'saml-user-property-mapper'),
('d9799981-f31f-4ca7-8ba0-e8e6c24e0044', '32b2da8d-7e52-4f44-a4e3-01bf7acd1b25', 'secret', 'S9e1ER5bvRT9h89m0y7Yxg'),
('daa71185-cb9e-463a-984a-440c194b6ecf', 'a41c2acb-9a34-41f6-94e8-54230bc3e9e9', 'allow-default-scopes', 'true'),
('e1af2da3-7b58-4b35-a5f2-3181b7cd76c8', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'saml-user-property-mapper'),
('ed1ef9b0-8573-4190-b83f-2565f45fe3fe', '742d5f17-05ab-4458-a527-6cf1954fb870', 'host-sending-registration-request-must-match', 'true'),
('ef29f499-2926-4d94-9140-ee4be268cab7', '10b46109-a94e-42de-9dfb-15782f753591', 'kid', '45fa97ee-57e4-4626-a3f4-5b18cc6d9f64'),
('ef4334fd-f04f-40f7-98bb-818d4a0e1079', 'b1debe46-8310-4512-af85-f66b8ff37a0c', 'privateKey', 'MIIEowIBAAKCAQEAp5HkTQoJvrANA/DL8BrP9P1N5GnvSxm+xVE+xG1D672JghUNZd1gYkEkPV8fiiZvyq5Bz8yV1qS4/DS2juORSxip4Xlxba4wjfDHX7WRvUL7FuY1GfbUunkC7fbCvER0dCVoJS2zTSZx1L9aMSQdAqtnDjZjRxXaz0wt9v+zXQR59P/IgOSgMbUogkWXuhbYtCpb8ckxkR1A4B1xGv/xvZQv2+Fb7Qf/Cg801fGTodCTZ4OZ3Awt805jwzHptR0VAGL0vEnc6/I+GCNoVld6f8MHWB9Oy37uoob4lLCkdVeX5pbY5kvXOd0Ql6Pkw4QRjOgOToetX0Ad/GLui0HQQQIDAQABAoIBAED3YpRttl58QeeLtX2G36ZDiK3sVk5/EkPM3nFoTWN5zfSlddbO773YNJUoqoE0qrXhPnmyf0tC/McnJroaR2veiYp1u4DC/mcheSLFsdW3QMLdiKvi0xHitbyNpW05ew7Gq+xyHehk5dAOSgjwT+EHlAJiGrZmJjmldtKiyybd4z/9dCE9R/eZE+koKYBM8qSDgec7RSTpubJG6EM3wEGQxKvtPtB1LzD+y7ISN+qSFEY+Msx5rPTKK0wu5vBsEpE62bURDfyLGnyE9+TuA4P2zDwRCszBdceV1LH+duOx8G4vH8vXJL86+s8MmwjxBnNqe7DCA1naU0Tu5Fy2/GMCgYEA1XxaqkpoZR/cSsDF8VXmfau+6K1KffsEQDd8zu6s3WlakMYGGLs3vCCJysd3xb435cg5P7W1XDJAmv9dJJGTUVUlMe8vVjdpd7b/+6pmDMyv/DJTgBezLQGvoy4PDn7Qog2txPsEAzaHKKg+dHrExtX5ekSrRWuDOvwhS+y2IWcCgYEAyPC3VUSKk3O6mD5Xf37rWuHUXaxzac6+IbiTY5a3Glc/WM18Z85x+X29ck9C43pHU4KKZ+fq3hTo7XspGDokYYwA3v95CFlZ7d+nvXolgOxs3lVx3a+6VzoWHYzDzYwVKGTphXVwjpW+VjhG/CZjvjv7nqka6ucsDVR+svXisBcCgYBhWZSKhOW3/2BYIjHhTDeP5QpoVeVbL2UP132taz8etBUdYX+UNYND4V6UPoNKg+Q/fx9EAxtRkITPaVVTAKM5+ma8r4JZgWkxsxxl6Z0hhxFVIqnbBnOpOVSbR7yL8p4215/+7Cw3Pt1BV/8q5HTo6tgZvkiPnmg4NJMGaUngTwKBgQCwTGLN8SEUVgl04d2rAxRD3LeSqGdqgfXXaDYIvodQGRR/OWrZOQxOtb+tt1UceIB0CKiemaA70WS8V76qfvjEjS2GeecbKCn6xqxJVg3pm4W5XIZW1oNLXK9ipcp1YV5+3mr0qSFkOIWS6DV/rb79fWs6vWvchY7k8ylmos2NaQKBgAit0HcWJooEDvBZaNfKHSVRAE+oo65yY0uOemeEjtc5bIFpehqeDjp1FNZFShFHyj2rFiixZBRtPC63psO3xPKNkFE+Tm2m62LE7vFVAZRZfflGNYIH7bCOJXh3wd3RW7Mf9XmF6kZDndzHfPzza2s109IHsZcalfnU+aHG5bnb'),
('f004035b-e825-4942-ac3a-6f69d69d9e71', '0e849816-8818-4e55-8588-bd02750693b6', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper'),
('f0869566-52b0-4dbb-875a-0f89163d22bb', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'saml-role-list-mapper'),
('f1133820-af44-4edc-a2da-ba6360e4fdff', 'f83b0bbc-169e-4fa8-a202-f2f89c4870b9', 'allowed-protocol-mapper-types', 'oidc-address-mapper'),
('f2abd7ac-4603-4073-bac8-e03a0910fc42', 'e11edd29-c7fd-49e4-b7ba-2a79076cb0fa', 'algorithm', 'HS256'),
('f32b47cb-7e02-498e-bc7f-37b65f876876', 'caf081ec-8922-4003-b18b-10e17eb302d9', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper'),
('fe3052cb-342b-4012-89ad-fd35506c341e', '10b46109-a94e-42de-9dfb-15782f753591', 'secret', 'x_i05Pt_QYSPrQ1ES_YSrl9t0D3U5nOoNj1TF24Tib6WUT0lxBy7_ZCViSDETXA-QgDJ7h-19t3brP4V17z1sg');

-- --------------------------------------------------------

--
-- Table structure for table `COMPOSITE_ROLE`
--

CREATE TABLE `COMPOSITE_ROLE` (
  `COMPOSITE` varchar(36) NOT NULL,
  `CHILD_ROLE` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COMPOSITE_ROLE`
--

INSERT INTO `COMPOSITE_ROLE` (`COMPOSITE`, `CHILD_ROLE`) VALUES
('03bf6778-5299-4a8b-991a-01afb89aa4f5', '8682edac-3e8b-45e3-b049-255180ee0462'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '03bf6778-5299-4a8b-991a-01afb89aa4f5'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '157f602f-599a-41d4-9527-65a2180cbfa1'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '17439c42-6509-4b57-9e38-8e20b6c84341'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '17f0a764-eef6-4494-b4d2-89eb5f19c8ab'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '194f8777-4b08-40d0-bf18-b78691a759be'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '24f6d3e7-0863-4cf3-9943-8c5fc5b9d106'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '29fd78d5-184b-416c-8f94-22356544a5e8'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '30108fa7-f3dd-40d7-a002-c239aff6889d'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '3a4d30be-b484-4e08-bcdd-d3bde5ef7f12'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '3bc2e5d2-12cd-4ddc-9c38-479f1aeee689'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '3cf1bd94-8e8b-48c9-8f14-dad42b21da04'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '41b1f35a-61fa-477a-b52e-4e88e2c3df95'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '4d6cf2a7-c60f-4189-b9e7-51ee20677d1f'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '4e939a44-1323-40cd-ad7c-36fbbbf9ff36'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '516e1cd5-46e2-49a2-81fc-0d2f5fc87d54'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '518876cd-e924-48cb-981a-817355011f37'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '552e6c09-3838-48de-a43c-d4e483cee349'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '56e103e8-d8f1-49cf-befd-7d9e653403d4'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '57489573-7cb3-4745-89a5-46c89f319094'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '5778e83f-8eeb-48dd-a2cd-bda6ef3bac02'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '659c175b-750e-4d8f-a8d5-4d3f0dadef44'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '66899447-86be-4f29-bf47-ef0314ca33a4'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '84ddf69f-5c01-4bc9-b7d9-e2232c3aadf7'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '8682edac-3e8b-45e3-b049-255180ee0462'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '89670f3a-9baa-4caf-9d10-ff8cdb13f94d'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '8dfb93f0-bc92-4f8b-93bd-854da423a7a6'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '905831c6-10cc-4141-96ed-f25d05a7597b'),
('0a7b5354-ce19-4902-81b8-651d2d340817', '9d3e9d64-547d-43a3-a632-0fb8a5b62d36'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'ab14a589-49e2-4f62-b332-02ab32ec5610'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'b713ed98-880e-4596-a09c-e731dfeb4675'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'bcb96ea5-a402-41dc-805c-2ddd52bf3a7d'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'c20bda4c-16ae-4cfb-a6e4-74b66de9528e'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'c55012cf-00ba-427e-a2ac-89361814ab6a'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'd056760b-7b01-42c8-b7c8-45d4c728dcda'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'd595252d-4c3d-4985-a092-5024c6f8a45c'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'e456ae00-5f98-4097-ab1a-ef8a10d97aa4'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'f7034714-bb75-4bd7-a7f3-8b4217243615'),
('1496568b-d89a-4d37-b5cc-93fbe12cf797', '96df85d9-3c86-4f75-a960-63353a0a7cc1'),
('17f0a764-eef6-4494-b4d2-89eb5f19c8ab', '24f6d3e7-0863-4cf3-9943-8c5fc5b9d106'),
('17f0a764-eef6-4494-b4d2-89eb5f19c8ab', '4d6cf2a7-c60f-4189-b9e7-51ee20677d1f'),
('1826d3f2-39ba-4c06-af1c-1d7f80968540', 'a54aab0d-2b7f-4ae1-871d-21d05e90b48c'),
('1826d3f2-39ba-4c06-af1c-1d7f80968540', 'd50ac9a8-ad04-4f99-b5cc-4dbc7d1dca75'),
('192e078c-d856-494b-bb67-fc7cb0b1afd2', 'e749f0f7-0bbc-4ceb-8a3d-c77917614b09'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '02d1d902-7ecc-47df-820b-f30a9652adc8'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '1826d3f2-39ba-4c06-af1c-1d7f80968540'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '192e078c-d856-494b-bb67-fc7cb0b1afd2'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '2a4e95b4-570b-44cc-b297-b2aa91c2cb9b'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '368d453f-45fc-4d6a-a0ab-d52ee83a0313'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '3bb647e4-bab7-412c-88bc-cbb3452655a2'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '52636bb2-decc-4ab8-b2a8-27b9e5a1901b'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '58245508-63a8-4e4b-a4c8-2a91248dd2ab'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '5d3be47b-5e8b-4b85-ae4e-f736da8b4b16'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '628ca114-5667-49fe-b1a1-a88a5604c876'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '68e40ed8-e6bc-45dd-93c0-2fa44f3579c3'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '71aeac8e-8020-457b-88cc-3cbd08d5e9b0'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', 'a54aab0d-2b7f-4ae1-871d-21d05e90b48c'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', 'ce4d7089-7e02-4ae2-8e04-4d43a6097913'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', 'd50ac9a8-ad04-4f99-b5cc-4dbc7d1dca75'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', 'e6ada9ec-07c0-4422-8ace-878710268385'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', 'e749f0f7-0bbc-4ceb-8a3d-c77917614b09'),
('24e0cc5e-1924-41da-a689-9c5f7227a478', 'fd05bf73-42f8-40ae-8dda-bd47082c22d2'),
('59c23e2d-ba5a-4d7a-afa4-252cfd8705d3', '80b2dcb0-507e-4607-a1cb-3d7ba1f2c6e0'),
('66899447-86be-4f29-bf47-ef0314ca33a4', '552e6c09-3838-48de-a43c-d4e483cee349'),
('66899447-86be-4f29-bf47-ef0314ca33a4', '9d3e9d64-547d-43a3-a632-0fb8a5b62d36'),
('8dfb93f0-bc92-4f8b-93bd-854da423a7a6', 'c20bda4c-16ae-4cfb-a6e4-74b66de9528e'),
('9ffdde51-ca66-4a03-bb03-94d2655f81bd', '93fe12da-4d6d-4814-9753-f7981f3a6235'),
('9ffdde51-ca66-4a03-bb03-94d2655f81bd', 'c2e7fab1-fc1b-400d-973a-2a30534cc777'),
('9ffdde51-ca66-4a03-bb03-94d2655f81bd', 'ea446258-35b2-411f-9452-87d625c5abb6'),
('9ffdde51-ca66-4a03-bb03-94d2655f81bd', 'ef08b375-940f-42a0-a9e8-77066e60ae8b'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '1496568b-d89a-4d37-b5cc-93fbe12cf797'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '248fd270-4165-40d7-8008-cb40c3d6def3'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '78b9c701-a217-4105-a786-f15b6fdd5d2e'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '7f5ac521-2f76-4077-b4b7-cd74892143e9'),
('ef08b375-940f-42a0-a9e8-77066e60ae8b', 'c63e7600-b9e0-442b-910d-aba65732e0fc'),
('fdfad488-761e-4083-8a83-ee569ac77faa', '63cd6aaa-cc44-4e78-8688-6f9a9b84f7ba');

-- --------------------------------------------------------

--
-- Table structure for table `CREDENTIAL`
--

CREATE TABLE `CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CREDENTIAL`
--

INSERT INTO `CREDENTIAL` (`ID`, `SALT`, `TYPE`, `USER_ID`, `CREATED_DATE`, `USER_LABEL`, `SECRET_DATA`, `CREDENTIAL_DATA`, `PRIORITY`) VALUES
('2f684111-59dd-47f2-b481-3b20dc38d194', NULL, 'password', '801b5074-17de-48ad-a636-c30d530c12f6', 1673938049430, NULL, '{\"value\":\"XkWmp/xd3rYxHPS80rvVA9Mm/g1/+r8xdgSIzJG0/TsEy+MU8ya+lC9+x/lgYrIziXj9P5trWscI9lX3dO1D7g==\",\"salt\":\"xY8nll7vyC5dhXoMtQhNVQ==\",\"additionalParameters\":{}}', '{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}', 10),
('99205d8a-8ce5-4f0a-8e63-0a2888b998b8', NULL, 'password', '4c996821-0851-4305-94f8-b416c08a8516', 1673430336195, 'My password', '{\"value\":\"pY0zn1C6J6MXOvxHLta8NqqOS9t22sIZlvYH+/DVU2T7Jkex/tCZgmLaXdXFZgccfgVnRjw37h1GL/cDF/Txlg==\",\"salt\":\"iV7LH/VpgFMexDX03BYQ7Q==\",\"additionalParameters\":{}}', '{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}', 10),
('cf42d58f-afc7-48ad-a99f-8f29aabc7c03', NULL, 'password', 'be5161db-84d8-47d2-a962-799878755e67', 1673343478232, NULL, '{\"value\":\"P1QxSmTZ8WNQ6js9Y8Znai74xt6Q+201q3tED9fU1IYu+uuWoVW0ekyMBSjB/tAbgUntR0jDIO9tQGJ0FERYtw==\",\"salt\":\"BBL4hBtckXec+9+Kf7HvxA==\",\"additionalParameters\":{}}', '{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}', 10);

-- --------------------------------------------------------

--
-- Table structure for table `DATABASECHANGELOG`
--

CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DATABASECHANGELOG`
--

INSERT INTO `DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES
('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2023-01-10 09:37:47', 1, 'EXECUTED', '8:bda77d94bf90182a1e30c24f1c155ec7', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2023-01-10 09:37:47', 2, 'MARK_RAN', '8:1ecb330f30986693d1cba9ab579fa219', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2023-01-10 09:37:47', 3, 'EXECUTED', '8:cb7ace19bc6d959f305605d255d4c843', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2023-01-10 09:37:47', 4, 'EXECUTED', '8:80230013e961310e6872e871be424a63', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2023-01-10 09:37:48', 5, 'EXECUTED', '8:67f4c20929126adc0c8e9bf48279d244', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2023-01-10 09:37:48', 6, 'MARK_RAN', '8:7311018b0b8179ce14628ab412bb6783', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2023-01-10 09:37:49', 7, 'EXECUTED', '8:037ba1216c3640f8785ee6b8e7c8e3c1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2023-01-10 09:37:49', 8, 'MARK_RAN', '8:7fe6ffe4af4df289b3157de32c624263', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2023-01-10 09:37:49', 9, 'EXECUTED', '8:9c136bc3187083a98745c7d03bc8a303', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2023-01-10 09:37:49', 10, 'EXECUTED', '8:b5f09474dca81fb56a97cf5b6553d331', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2023-01-10 09:37:49', 11, 'EXECUTED', '8:ca924f31bd2a3b219fdcfe78c82dacf4', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2023-01-10 09:37:49', 12, 'MARK_RAN', '8:8acad7483e106416bcfa6f3b824a16cd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2023-01-10 09:37:49', 13, 'EXECUTED', '8:9b1266d17f4f87c78226f5055408fd5e', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-10 09:37:49', 14, 'EXECUTED', '8:d80ec4ab6dbfe573550ff72396c7e910', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-10 09:37:49', 15, 'MARK_RAN', '8:d86eb172171e7c20b9c849b584d147b2', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-10 09:37:49', 16, 'MARK_RAN', '8:5735f46f0fa60689deb0ecdc2a0dea22', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2023-01-10 09:37:49', 17, 'EXECUTED', '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2023-01-10 09:37:50', 18, 'EXECUTED', '8:5c1a8fd2014ac7fc43b90a700f117b23', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2023-01-10 09:37:50', 19, 'EXECUTED', '8:1f6c2c2dfc362aff4ed75b3f0ef6b331', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2023-01-10 09:37:50', 20, 'EXECUTED', '8:dee9246280915712591f83a127665107', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2023-01-10 09:37:50', 21, 'MARK_RAN', '8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2023-01-10 09:37:50', 22, 'MARK_RAN', '8:dee9246280915712591f83a127665107', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2023-01-10 09:37:50', 23, 'EXECUTED', '8:d9fa18ffa355320395b86270680dd4fe', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2023-01-10 09:37:50', 24, 'EXECUTED', '8:90cff506fedb06141ffc1c71c4a1214c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2023-01-10 09:37:50', 25, 'MARK_RAN', '8:11a788aed4961d6d29c427c063af828c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2023-01-10 09:37:50', 26, 'EXECUTED', '8:a4218e51e1faf380518cce2af5d39b43', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2023-01-10 09:37:50', 27, 'EXECUTED', '8:d9e9a1bfaa644da9952456050f07bbdc', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2023-01-10 09:37:50', 28, 'EXECUTED', '8:d1bf991a6163c0acbfe664b615314505', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2023-01-10 09:37:51', 29, 'EXECUTED', '8:88a743a1e87ec5e30bf603da68058a8c', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2023-01-10 09:37:51', 30, 'EXECUTED', '8:c5517863c875d325dea463d00ec26d7a', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2023-01-10 09:37:51', 31, 'EXECUTED', '8:ada8b4833b74a498f376d7136bc7d327', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2023-01-10 09:37:51', 32, 'EXECUTED', '8:b9b73c8ea7299457f99fcbb825c263ba', 'customChange', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-10 09:37:51', 33, 'EXECUTED', '8:07724333e625ccfcfc5adc63d57314f3', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-10 09:37:51', 34, 'MARK_RAN', '8:8b6fd445958882efe55deb26fc541a7b', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-10 09:37:51', 35, 'EXECUTED', '8:29b29cfebfd12600897680147277a9d7', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-10 09:37:51', 36, 'EXECUTED', '8:73ad77ca8fd0410c7f9f15a471fa52bc', 'addColumn tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2023-01-10 09:37:51', 37, 'EXECUTED', '8:64f27a6fdcad57f6f9153210f2ec1bdb', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2023-01-10 09:37:51', 38, 'EXECUTED', '8:27180251182e6c31846c2ddab4bc5781', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2023-01-10 09:37:51', 39, 'EXECUTED', '8:d56f201bfcfa7a1413eb3e9bc02978f9', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-10 09:37:51', 40, 'MARK_RAN', '8:91f5522bf6afdc2077dfab57fbd3455c', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-10 09:37:51', 41, 'MARK_RAN', '8:0f01b554f256c22caeb7d8aee3a1cdc8', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-10 09:37:51', 42, 'EXECUTED', '8:ab91cf9cee415867ade0e2df9651a947', 'customChange', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2023-01-10 09:37:52', 43, 'EXECUTED', '8:ceac9b1889e97d602caf373eadb0d4b7', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2023-01-10 09:37:52', 44, 'EXECUTED', '8:84b986e628fe8f7fd8fd3c275c5259f2', 'addColumn tableName=USER_ENTITY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-10 09:37:52', 45, 'EXECUTED', '8:a164ae073c56ffdbc98a615493609a52', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-10 09:37:52', 46, 'EXECUTED', '8:70a2b4f1f4bd4dbf487114bdb1810e64', 'customChange', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-10 09:37:52', 47, 'MARK_RAN', '8:7be68b71d2f5b94b8df2e824f2860fa2', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-10 09:37:52', 48, 'EXECUTED', '8:bab7c631093c3861d6cf6144cd944982', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2023-01-10 09:37:52', 49, 'EXECUTED', '8:fa809ac11877d74d76fe40869916daad', 'addColumn tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2023-01-10 09:37:52', 50, 'EXECUTED', '8:fac23540a40208f5f5e326f6ceb4d291', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2023-01-10 09:37:52', 51, 'EXECUTED', '8:2612d1b8a97e2b5588c346e817307593', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2023-01-10 09:37:52', 52, 'EXECUTED', '8:9842f155c5db2206c88bcb5d1046e941', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2023-01-10 09:37:52', 53, 'EXECUTED', '8:2e12e06e45498406db72d5b3da5bbc76', 'update tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2023-01-10 09:37:52', 54, 'EXECUTED', '8:33560e7c7989250c40da3abdabdc75a4', 'update tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-10 09:37:53', 55, 'EXECUTED', '8:87a8d8542046817a9107c7eb9cbad1cd', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-10 09:37:53', 56, 'EXECUTED', '8:3ea08490a70215ed0088c273d776311e', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-10 09:37:53', 57, 'EXECUTED', '8:2d56697c8723d4592ab608ce14b6ed68', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2023-01-10 09:37:53', 58, 'EXECUTED', '8:3e423e249f6068ea2bbe48bf907f9d86', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2023-01-10 09:37:53', 59, 'EXECUTED', '8:15cabee5e5df0ff099510a0fc03e4103', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2023-01-10 09:37:54', 60, 'EXECUTED', '8:4b80200af916ac54d2ffbfc47918ab0e', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2023-01-10 09:37:54', 61, 'EXECUTED', '8:66564cd5e168045d52252c5027485bbb', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2023-01-10 09:37:54', 62, 'EXECUTED', '8:1c7064fafb030222be2bd16ccf690f6f', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2023-01-10 09:37:54', 63, 'EXECUTED', '8:2de18a0dce10cdda5c7e65c9b719b6e5', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2023-01-10 09:37:54', 64, 'EXECUTED', '8:03e413dd182dcbd5c57e41c34d0ef682', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2023-01-10 09:37:54', 65, 'EXECUTED', '8:d27b42bb2571c18fbe3fe4e4fb7582a7', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2023-01-10 09:37:54', 66, 'EXECUTED', '8:698baf84d9fd0027e9192717c2154fb8', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2023-01-10 09:37:54', 67, 'EXECUTED', '8:ced8822edf0f75ef26eb51582f9a821a', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2023-01-10 09:37:54', 68, 'EXECUTED', '8:f0abba004cf429e8afc43056df06487d', 'addColumn tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2023-01-10 09:37:54', 69, 'EXECUTED', '8:6662f8b0b611caa359fcf13bf63b4e24', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2023-01-10 09:37:54', 70, 'EXECUTED', '8:9e6b8009560f684250bdbdf97670d39e', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2023-01-10 09:37:54', 71, 'EXECUTED', '8:4223f561f3b8dc655846562b57bb502e', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-10 09:37:54', 72, 'EXECUTED', '8:215a31c398b363ce383a2b301202f29e', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-10 09:37:54', 73, 'EXECUTED', '8:83f7a671792ca98b3cbd3a1a34862d3d', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-10 09:37:54', 74, 'MARK_RAN', '8:f58ad148698cf30707a6efbdf8061aa7', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-10 09:37:54', 75, 'EXECUTED', '8:79e4fd6c6442980e58d52ffc3ee7b19c', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2023-01-10 09:37:54', 76, 'EXECUTED', '8:87af6a1e6d241ca4b15801d1f86a297d', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-10 09:37:54', 77, 'EXECUTED', '8:b44f8d9b7b6ea455305a6d72a200ed15', 'addColumn tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-10 09:37:54', 78, 'MARK_RAN', '8:2d8ed5aaaeffd0cb004c046b4a903ac5', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-10 09:37:54', 79, 'EXECUTED', '8:e290c01fcbc275326c511633f6e2acde', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2023-01-10 09:37:54', 80, 'MARK_RAN', '8:c9db8784c33cea210872ac2d805439f8', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-10 09:37:54', 81, 'EXECUTED', '8:95b676ce8fc546a1fcfb4c92fae4add5', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-10 09:37:54', 82, 'MARK_RAN', '8:38a6b2a41f5651018b1aca93a41401e5', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-10 09:37:54', 83, 'EXECUTED', '8:3fb99bcad86a0229783123ac52f7609c', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-10 09:37:54', 84, 'MARK_RAN', '8:64f27a6fdcad57f6f9153210f2ec1bdb', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2023-01-10 09:37:54', 85, 'EXECUTED', '8:ab4f863f39adafd4c862f7ec01890abc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2023-01-10 09:37:54', 86, 'EXECUTED', '8:13c419a0eb336e91ee3a3bf8fda6e2a7', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2023-01-10 09:37:54', 87, 'EXECUTED', '8:e3fb1e698e0471487f51af1ed80fe3ac', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2023-01-10 09:37:54', 88, 'EXECUTED', '8:babadb686aab7b56562817e60bf0abd0', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 89, 'EXECUTED', '8:72d03345fda8e2f17093d08801947773', 'addColumn tableName=REALM; customChange', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 90, 'EXECUTED', '8:61c9233951bd96ffecd9ba75f7d978a4', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 91, 'EXECUTED', '8:ea82e6ad945cec250af6372767b25525', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 92, 'EXECUTED', '8:d3f4a33f41d960ddacd7e2ef30d126b3', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 93, 'MARK_RAN', '8:1284a27fbd049d65831cb6fc07c8a783', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 94, 'EXECUTED', '8:9d11b619db2ae27c25853b8a37cd0dea', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 95, 'MARK_RAN', '8:3002bb3997451bb9e8bac5c5cd8d6327', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2023-01-10 09:37:54', 96, 'EXECUTED', '8:dfbee0d6237a23ef4ccbb7a4e063c163', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 97, 'EXECUTED', '8:75f3e372df18d38c62734eebb986b960', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 98, 'MARK_RAN', '8:7fee73eddf84a6035691512c85637eef', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 99, 'MARK_RAN', '8:7a11134ab12820f999fbf3bb13c3adc8', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 100, 'EXECUTED', '8:f43dfba07ba249d5d932dc489fd2b886', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 101, 'MARK_RAN', '8:18186f0008b86e0f0f49b0c4d0e842ac', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 102, 'EXECUTED', '8:09c2780bcb23b310a7019d217dc7b433', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2023-01-10 09:37:54', 103, 'EXECUTED', '8:276a44955eab693c970a42880197fff2', 'customChange', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2023-01-10 09:37:54', 104, 'EXECUTED', '8:ba8ee3b694d043f2bfc1a1079d0760d7', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2023-01-10 09:37:54', 105, 'EXECUTED', '8:5e06b1d75f5d17685485e610c2851b17', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2023-01-10 09:37:54', 106, 'EXECUTED', '8:4b80546c1dc550ac552ee7b24a4ab7c0', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '3343466302'),
('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2023-01-10 09:37:54', 107, 'EXECUTED', '8:af510cd1bb2ab6339c45372f3e491696', 'customChange', '', NULL, '4.8.0', NULL, NULL, '3343466302');

-- --------------------------------------------------------

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

INSERT INTO `DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES
(1, b'0', NULL, NULL),
(1000, b'0', NULL, NULL),
(1001, b'0', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `DEFAULT_CLIENT_SCOPE`
--

CREATE TABLE `DEFAULT_CLIENT_SCOPE` (
  `REALM_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DEFAULT_CLIENT_SCOPE`
--

INSERT INTO `DEFAULT_CLIENT_SCOPE` (`REALM_ID`, `SCOPE_ID`, `DEFAULT_SCOPE`) VALUES
('ad3a9024-ffab-4299-a385-b777720941f3', '05fe0602-09d2-4228-82d8-db21503136cc', b'0'),
('ad3a9024-ffab-4299-a385-b777720941f3', '231a6440-2cf3-4020-a5be-1a209ab552ce', b'0'),
('ad3a9024-ffab-4299-a385-b777720941f3', '3f438c5b-9d88-48de-b8a9-aa2c5593a537', b'0'),
('ad3a9024-ffab-4299-a385-b777720941f3', '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88', b'0'),
('ad3a9024-ffab-4299-a385-b777720941f3', 'b931a622-74f5-4265-a072-c21e8b1d944f', b'1'),
('ad3a9024-ffab-4299-a385-b777720941f3', 'cca4f4a7-b3c2-45d4-8034-dfba20158d68', b'1'),
('ad3a9024-ffab-4299-a385-b777720941f3', 'eadfd131-108d-4761-9985-ff8091747d63', b'1'),
('ad3a9024-ffab-4299-a385-b777720941f3', 'f1902095-2d1b-4614-a307-e3375d1126fe', b'1'),
('ad3a9024-ffab-4299-a385-b777720941f3', 'f24ebe98-3cf3-4e2d-a8ef-5b5f9e41e5e1', b'1'),
('ad3a9024-ffab-4299-a385-b777720941f3', 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca', b'1'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '188a7535-1c89-4ef2-ad72-39b06946040a', b'1'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d', b'1'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '3dabe931-8924-440e-866f-0d4b49827f15', b'1'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '564ae84e-8c5e-4757-ab97-5adf27c4e07b', b'0'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5c2f341c-df67-49c8-97e3-5aa5c5251844', b'0'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5e71f713-b69c-4e03-8afa-cb36811ebf6b', b'1'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '630d39e3-d099-4760-80b0-75b564e63a0a', b'0'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7', b'1'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'e2725a2c-9249-48bb-8702-3b01772a1c03', b'0'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ebbbe116-6db8-48f4-b252-f1304bfbe66d', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `EVENT_ENTITY`
--

CREATE TABLE `EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON` varchar(2550) DEFAULT NULL,
  `ERROR` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(255) DEFAULT NULL,
  `EVENT_TIME` bigint(20) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FEDERATED_IDENTITY`
--

CREATE TABLE `FEDERATED_IDENTITY` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FEDERATED_USER_ID` varchar(255) DEFAULT NULL,
  `FEDERATED_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FEDERATED_USER`
--

CREATE TABLE `FEDERATED_USER` (
  `ID` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_ATTRIBUTE`
--

CREATE TABLE `FED_USER_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `VALUE` varchar(2024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_CONSENT`
--

CREATE TABLE `FED_USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint(20) DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_CONSENT_CL_SCOPE`
--

CREATE TABLE `FED_USER_CONSENT_CL_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_CREDENTIAL`
--

CREATE TABLE `FED_USER_CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_GROUP_MEMBERSHIP`
--

CREATE TABLE `FED_USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_REQUIRED_ACTION`
--

CREATE TABLE `FED_USER_REQUIRED_ACTION` (
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FED_USER_ROLE_MAPPING`
--

CREATE TABLE `FED_USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `GROUP_ATTRIBUTE`
--

CREATE TABLE `GROUP_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `GROUP_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `GROUP_ATTRIBUTE`
--

INSERT INTO `GROUP_ATTRIBUTE` (`ID`, `NAME`, `VALUE`, `GROUP_ID`) VALUES
('a59f269f-9999-46b3-af9d-2c1164bb6e8e', 'role', 'admin', '80f08200-a29d-4471-85ea-490aaf5569d9');

-- --------------------------------------------------------

--
-- Table structure for table `GROUP_ROLE_MAPPING`
--

CREATE TABLE `GROUP_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `GROUP_ROLE_MAPPING`
--

INSERT INTO `GROUP_ROLE_MAPPING` (`ROLE_ID`, `GROUP_ID`) VALUES
('1826d3f2-39ba-4c06-af1c-1d7f80968540', '80f08200-a29d-4471-85ea-490aaf5569d9'),
('368d453f-45fc-4d6a-a0ab-d52ee83a0313', '80f08200-a29d-4471-85ea-490aaf5569d9'),
('63477bfb-8646-4d10-b688-8fa49e94527b', '80f08200-a29d-4471-85ea-490aaf5569d9'),
('d50ac9a8-ad04-4f99-b5cc-4dbc7d1dca75', '80f08200-a29d-4471-85ea-490aaf5569d9'),
('a2139258-78be-410a-9d78-2547a404dc87', '98efd447-f872-4e49-aaf6-b2ef87d6f814');

-- --------------------------------------------------------

--
-- Table structure for table `IDENTITY_PROVIDER`
--

CREATE TABLE `IDENTITY_PROVIDER` (
  `INTERNAL_ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ALIAS` varchar(255) DEFAULT NULL,
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `STORE_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `AUTHENTICATE_BY_DEFAULT` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ADD_TOKEN_ROLE` bit(1) NOT NULL DEFAULT b'1',
  `TRUST_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `FIRST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `POST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `LINK_ONLY` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `IDENTITY_PROVIDER`
--

INSERT INTO `IDENTITY_PROVIDER` (`INTERNAL_ID`, `ENABLED`, `PROVIDER_ALIAS`, `PROVIDER_ID`, `STORE_TOKEN`, `AUTHENTICATE_BY_DEFAULT`, `REALM_ID`, `ADD_TOKEN_ROLE`, `TRUST_EMAIL`, `FIRST_BROKER_LOGIN_FLOW_ID`, `POST_BROKER_LOGIN_FLOW_ID`, `PROVIDER_DISPLAY_NAME`, `LINK_ONLY`) VALUES
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', b'1', 'google', 'google', b'0', b'0', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', b'1', 'd02ee3fb-2855-4b38-b754-85604f3f7ba6', NULL, NULL, b'0');

-- --------------------------------------------------------

--
-- Table structure for table `IDENTITY_PROVIDER_CONFIG`
--

CREATE TABLE `IDENTITY_PROVIDER_CONFIG` (
  `IDENTITY_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `IDENTITY_PROVIDER_CONFIG`
--

INSERT INTO `IDENTITY_PROVIDER_CONFIG` (`IDENTITY_PROVIDER_ID`, `VALUE`, `NAME`) VALUES
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', 'false', 'acceptsPromptNoneForwardFromClient'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', '693143633322-u7qc7jjju8j6aufv2gjpqlv7j1c0ra7u.apps.googleusercontent.com', 'clientId'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', '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', 'clientSecret'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', 'false', 'disableUserInfo'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', 'false', 'hideOnLoginPage'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', 'false', 'offlineAccess'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', 'IMPORT', 'syncMode'),
('eacc29ee-6c51-4edc-b5d6-1804fbe92fe1', 'false', 'userIp');

-- --------------------------------------------------------

--
-- Table structure for table `IDENTITY_PROVIDER_MAPPER`
--

CREATE TABLE `IDENTITY_PROVIDER_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `IDP_ALIAS` varchar(255) NOT NULL,
  `IDP_MAPPER_NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `IDP_MAPPER_CONFIG`
--

CREATE TABLE `IDP_MAPPER_CONFIG` (
  `IDP_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `KEYCLOAK_GROUP`
--

CREATE TABLE `KEYCLOAK_GROUP` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `PARENT_GROUP` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `KEYCLOAK_GROUP`
--

INSERT INTO `KEYCLOAK_GROUP` (`ID`, `NAME`, `PARENT_GROUP`, `REALM_ID`) VALUES
('80f08200-a29d-4471-85ea-490aaf5569d9', 'admin-dms', ' ', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf'),
('98efd447-f872-4e49-aaf6-b2ef87d6f814', 'user-dms', ' ', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf');

-- --------------------------------------------------------

--
-- Table structure for table `KEYCLOAK_ROLE`
--

CREATE TABLE `KEYCLOAK_ROLE` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_REALM_CONSTRAINT` varchar(255) DEFAULT NULL,
  `CLIENT_ROLE` bit(1) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(36) DEFAULT NULL,
  `REALM` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `KEYCLOAK_ROLE`
--

INSERT INTO `KEYCLOAK_ROLE` (`ID`, `CLIENT_REALM_CONSTRAINT`, `CLIENT_ROLE`, `DESCRIPTION`, `NAME`, `REALM_ID`, `CLIENT`, `REALM`) VALUES
('0105dded-0673-48cd-89bf-eca27c40afa7', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_view-applications}', 'view-applications', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('02d1d902-7ecc-47df-820b-f30a9652adc8', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_manage-identity-providers}', 'manage-identity-providers', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('03bf6778-5299-4a8b-991a-01afb89aa4f5', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_view-clients}', 'view-clients', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', '${role_admin}', 'admin', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, NULL),
('1496568b-d89a-4d37-b5cc-93fbe12cf797', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_manage-account}', 'manage-account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL),
('157f602f-599a-41d4-9527-65a2180cbfa1', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_manage-authorization}', 'manage-authorization', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('17439c42-6509-4b57-9e38-8e20b6c84341', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_manage-users}', 'manage-users', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('17f0a764-eef6-4494-b4d2-89eb5f19c8ab', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_view-users}', 'view-users', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('1826d3f2-39ba-4c06-af1c-1d7f80968540', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_view-users}', 'view-users', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('192e078c-d856-494b-bb67-fc7cb0b1afd2', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_view-clients}', 'view-clients', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('194f8777-4b08-40d0-bf18-b78691a759be', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_manage-users}', 'manage-users', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('248fd270-4165-40d7-8008-cb40c3d6def3', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', '${role_uma_authorization}', 'uma_authorization', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL, NULL),
('24e0cc5e-1924-41da-a689-9c5f7227a478', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_realm-admin}', 'realm-admin', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('24f6d3e7-0863-4cf3-9943-8c5fc5b9d106', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_query-groups}', 'query-groups', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('29fd78d5-184b-416c-8f94-22356544a5e8', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_manage-events}', 'manage-events', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('2a4e95b4-570b-44cc-b297-b2aa91c2cb9b', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_view-realm}', 'view-realm', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('30108fa7-f3dd-40d7-a002-c239aff6889d', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_view-events}', 'view-events', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('368d453f-45fc-4d6a-a0ab-d52ee83a0313', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_manage-users}', 'manage-users', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('3a4d30be-b484-4e08-bcdd-d3bde5ef7f12', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_manage-identity-providers}', 'manage-identity-providers', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('3bb647e4-bab7-412c-88bc-cbb3452655a2', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_view-authorization}', 'view-authorization', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('3bc2e5d2-12cd-4ddc-9c38-479f1aeee689', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_impersonation}', 'impersonation', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('3cf1bd94-8e8b-48c9-8f14-dad42b21da04', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_manage-realm}', 'manage-realm', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('41b1f35a-61fa-477a-b52e-4e88e2c3df95', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', '${role_create-realm}', 'create-realm', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, NULL),
('4d6cf2a7-c60f-4189-b9e7-51ee20677d1f', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_query-users}', 'query-users', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('4e939a44-1323-40cd-ad7c-36fbbbf9ff36', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_query-realms}', 'query-realms', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('516e1cd5-46e2-49a2-81fc-0d2f5fc87d54', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_impersonation}', 'impersonation', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('518876cd-e924-48cb-981a-817355011f37', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_view-identity-providers}', 'view-identity-providers', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('52636bb2-decc-4ab8-b2a8-27b9e5a1901b', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_view-identity-providers}', 'view-identity-providers', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('552e6c09-3838-48de-a43c-d4e483cee349', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_query-groups}', 'query-groups', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('56e103e8-d8f1-49cf-befd-7d9e653403d4', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_manage-authorization}', 'manage-authorization', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('57489573-7cb3-4745-89a5-46c89f319094', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_create-client}', 'create-client', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('5778e83f-8eeb-48dd-a2cd-bda6ef3bac02', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_view-identity-providers}', 'view-identity-providers', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('58245508-63a8-4e4b-a4c8-2a91248dd2ab', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_view-events}', 'view-events', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('59c23e2d-ba5a-4d7a-afa4-252cfd8705d3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_manage-consent}', 'manage-consent', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('5d3be47b-5e8b-4b85-ae4e-f736da8b4b16', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_manage-clients}', 'manage-clients', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('628ca114-5667-49fe-b1a1-a88a5604c876', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_manage-events}', 'manage-events', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('63477bfb-8646-4d10-b688-8fa49e94527b', '68c51fb6-dfff-40f6-9e26-9464e60b6894', b'1', NULL, 'admin', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('63cd6aaa-cc44-4e78-8688-6f9a9b84f7ba', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_view-consent}', 'view-consent', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL),
('659c175b-750e-4d8f-a8d5-4d3f0dadef44', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_query-realms}', 'query-realms', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('66899447-86be-4f29-bf47-ef0314ca33a4', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_view-users}', 'view-users', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('68e40ed8-e6bc-45dd-93c0-2fa44f3579c3', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_manage-realm}', 'manage-realm', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('6c47bbdb-17d1-4289-8c7b-42d74f324808', '487b979b-2296-4208-a510-cd0ec0c60fd4', b'1', '${role_read-token}', 'read-token', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '487b979b-2296-4208-a510-cd0ec0c60fd4', NULL),
('71aeac8e-8020-457b-88cc-3cbd08d5e9b0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_create-client}', 'create-client', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('78b9c701-a217-4105-a786-f15b6fdd5d2e', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', '${role_offline-access}', 'offline_access', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL, NULL),
('7f5ac521-2f76-4077-b4b7-cd74892143e9', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_view-profile}', 'view-profile', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL),
('80b2dcb0-507e-4607-a1cb-3d7ba1f2c6e0', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_view-consent}', 'view-consent', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('84ddf69f-5c01-4bc9-b7d9-e2232c3aadf7', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_view-authorization}', 'view-authorization', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('8682edac-3e8b-45e3-b049-255180ee0462', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_query-clients}', 'query-clients', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('89670f3a-9baa-4caf-9d10-ff8cdb13f94d', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_manage-clients}', 'manage-clients', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('8dfb93f0-bc92-4f8b-93bd-854da423a7a6', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_view-clients}', 'view-clients', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('905831c6-10cc-4141-96ed-f25d05a7597b', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_manage-identity-providers}', 'manage-identity-providers', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('90e3c693-41a4-4a7b-a9d5-c1ca88231162', '6130f0db-ad03-4ef9-a0e3-52b600fb658c', b'1', '${role_read-token}', 'read-token', 'ad3a9024-ffab-4299-a385-b777720941f3', '6130f0db-ad03-4ef9-a0e3-52b600fb658c', NULL),
('93fe12da-4d6d-4814-9753-f7981f3a6235', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_view-profile}', 'view-profile', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('96df85d9-3c86-4f75-a960-63353a0a7cc1', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_manage-account-links}', 'manage-account-links', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL),
('9d3e9d64-547d-43a3-a632-0fb8a5b62d36', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_query-users}', 'query-users', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('9ffdde51-ca66-4a03-bb03-94d2655f81bd', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', '${role_default-roles}', 'default-roles-master', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, NULL),
('a2139258-78be-410a-9d78-2547a404dc87', '68c51fb6-dfff-40f6-9e26-9464e60b6894', b'1', NULL, 'user', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('a54aab0d-2b7f-4ae1-871d-21d05e90b48c', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_query-groups}', 'query-groups', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('a655f57c-6f35-4837-a074-44dcbedb31b8', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_delete-account}', 'delete-account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL),
('ab14a589-49e2-4f62-b332-02ab32ec5610', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_view-realm}', 'view-realm', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('b713ed98-880e-4596-a09c-e731dfeb4675', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_manage-realm}', 'manage-realm', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('bcb96ea5-a402-41dc-805c-2ddd52bf3a7d', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_create-client}', 'create-client', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('c20bda4c-16ae-4cfb-a6e4-74b66de9528e', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_query-clients}', 'query-clients', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('c2e7fab1-fc1b-400d-973a-2a30534cc777', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', '${role_uma_authorization}', 'uma_authorization', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, NULL),
('c55012cf-00ba-427e-a2ac-89361814ab6a', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_manage-clients}', 'manage-clients', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('c63e7600-b9e0-442b-910d-aba65732e0fc', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_manage-account-links}', 'manage-account-links', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', '${role_default-roles}', 'default-roles-demo', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', NULL, NULL),
('caecc87f-aa81-4d96-9d2a-f153c577d9ec', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_delete-account}', 'delete-account', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('ce4d7089-7e02-4ae2-8e04-4d43a6097913', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_query-realms}', 'query-realms', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('d056760b-7b01-42c8-b7c8-45d4c728dcda', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_view-authorization}', 'view-authorization', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('d50ac9a8-ad04-4f99-b5cc-4dbc7d1dca75', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_query-users}', 'query-users', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('d595252d-4c3d-4985-a092-5024c6f8a45c', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', b'1', '${role_manage-events}', 'manage-events', 'ad3a9024-ffab-4299-a385-b777720941f3', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', NULL),
('e456ae00-5f98-4097-ab1a-ef8a10d97aa4', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_view-realm}', 'view-realm', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('e6ada9ec-07c0-4422-8ace-878710268385', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_impersonation}', 'impersonation', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('e749f0f7-0bbc-4ceb-8a3d-c77917614b09', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_query-clients}', 'query-clients', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('ea446258-35b2-411f-9452-87d625c5abb6', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', '${role_offline-access}', 'offline_access', 'ad3a9024-ffab-4299-a385-b777720941f3', NULL, NULL),
('ea9dab55-f916-4254-95c9-d1d29b1270eb', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', NULL, 'uma_protection', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('ef08b375-940f-42a0-a9e8-77066e60ae8b', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', b'1', '${role_manage-account}', 'manage-account', 'ad3a9024-ffab-4299-a385-b777720941f3', 'ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', NULL),
('f7034714-bb75-4bd7-a7f3-8b4217243615', '40b87195-caf9-4928-89c6-ade363ef452e', b'1', '${role_view-events}', 'view-events', 'ad3a9024-ffab-4299-a385-b777720941f3', '40b87195-caf9-4928-89c6-ade363ef452e', NULL),
('fcbc0a55-f012-4e93-a948-f461c35c1405', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_view-applications}', 'view-applications', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL),
('fd05bf73-42f8-40ae-8dda-bd47082c22d2', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'1', '${role_manage-authorization}', 'manage-authorization', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('fdfad488-761e-4083-8a83-ee569ac77faa', 'aaef7869-4756-4677-ad53-16a60aadc460', b'1', '${role_manage-consent}', 'manage-consent', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'aaef7869-4756-4677-ad53-16a60aadc460', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `MIGRATION_MODEL`
--

CREATE TABLE `MIGRATION_MODEL` (
  `ID` varchar(36) NOT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `UPDATE_TIME` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `MIGRATION_MODEL`
--

INSERT INTO `MIGRATION_MODEL` (`ID`, `VERSION`, `UPDATE_TIME`) VALUES
('0gxaq', '19.0.3', 1673343475);

-- --------------------------------------------------------

--
-- Table structure for table `OFFLINE_CLIENT_SESSION`
--

CREATE TABLE `OFFLINE_CLIENT_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `DATA` longtext,
  `CLIENT_STORAGE_PROVIDER` varchar(36) NOT NULL DEFAULT 'local',
  `EXTERNAL_CLIENT_ID` varchar(255) NOT NULL DEFAULT 'local'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `OFFLINE_USER_SESSION`
--

CREATE TABLE `OFFLINE_USER_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `CREATED_ON` int(11) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `DATA` longtext,
  `LAST_SESSION_REFRESH` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `POLICY_CONFIG`
--

CREATE TABLE `POLICY_CONFIG` (
  `POLICY_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PROTOCOL_MAPPER`
--

CREATE TABLE `PROTOCOL_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PROTOCOL` varchar(255) NOT NULL,
  `PROTOCOL_MAPPER_NAME` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `CLIENT_SCOPE_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PROTOCOL_MAPPER`
--

INSERT INTO `PROTOCOL_MAPPER` (`ID`, `NAME`, `PROTOCOL`, `PROTOCOL_MAPPER_NAME`, `CLIENT_ID`, `CLIENT_SCOPE_ID`) VALUES
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('022f9c0e-da32-4dbd-84fe-fe93b956083a', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '5e71f713-b69c-4e03-8afa-cb36811ebf6b'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('0996473f-773e-446f-b798-b0144023ce6c', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '05fe0602-09d2-4228-82d8-db21503136cc'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'position', 'openid-connect', 'oidc-usermodel-attribute-mapper', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '77a90979-ac34-4353-9700-11005d688749', NULL),
('370cc118-fa35-48e5-b30b-90acb916149c', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '630d39e3-d099-4760-80b0-75b564e63a0a'),
('5298e884-ffd5-4cd2-bfea-58854586451e', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'f24ebe98-3cf3-4e2d-a8ef-5b5f9e41e5e1'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'dept', 'openid-connect', 'oidc-usermodel-attribute-mapper', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('550d61fd-a362-4189-8c1d-91922d139967', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'eadfd131-108d-4761-9985-ff8091747d63'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('5c988329-0f8f-4e54-a83d-561d5f48e64e', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'b931a622-74f5-4265-a072-c21e8b1d944f'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '3746d4a7-65dd-4f1e-b28f-ac4562ebf09d'),
('61d02cff-5dca-478d-83e7-4edef01065e1', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'ebbbe116-6db8-48f4-b252-f1304bfbe66d'),
('6412a264-e630-4a28-b893-f1c715036c7a', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'd9cf5761-0681-4a0f-8eb6-55c88a381ec7'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('73311ba9-c54f-4974-afed-10aa30116055', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '4acd89d8-9537-4d58-8486-df058afeaaeb', NULL),
('7942782e-b976-4fbb-855f-94e5507048b9', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '05fe0602-09d2-4228-82d8-db21503136cc'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('83357256-f16d-4311-b349-2a2ac2d1b240', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '9adfe4ca-2530-40fd-91a6-7773acca89bb', NULL),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '5c2f341c-df67-49c8-97e3-5aa5c5251844'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('9f340e36-68d7-40d7-ba52-f4dc1013241c', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('a29181d2-5fa5-4c13-b919-0909d5027720', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '4cc70347-b41c-4f63-8428-706b68bba5d7', NULL),
('a29b40af-95b0-469f-948e-0b1383028bea', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '8fb065bd-5f7c-4a24-bcdd-393b2ee3bb88'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('aac23750-4b05-43ae-8edd-b00a176c049b', 'role list', 'saml', 'saml-role-list-mapper', NULL, '188a7535-1c89-4ef2-ad72-39b06946040a'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '5c2f341c-df67-49c8-97e3-5aa5c5251844'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '3f438c5b-9d88-48de-b8a9-aa2c5593a537'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('baefe8fe-2de8-4b17-a62a-afcc6e7817be', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'cca4f4a7-b3c2-45d4-8034-dfba20158d68'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('c11c054b-2648-4424-92ac-257d76da818e', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'f3e0d29c-ebb5-4ea1-a6d5-6fb505deb1ca'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('d390c4a9-9e06-4172-a721-c4e0c0c9e845', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '5e71f713-b69c-4e03-8afa-cb36811ebf6b'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('de39b4d5-2e83-414d-87eb-543126eefcfe', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f1902095-2d1b-4614-a307-e3375d1126fe'),
('deecd0d8-3146-458e-bc93-38061720c7c9', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '5e71f713-b69c-4e03-8afa-cb36811ebf6b'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '68c51fb6-dfff-40f6-9e26-9464e60b6894', NULL),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e2725a2c-9249-48bb-8702-3b01772a1c03'),
('e8b6ccd6-0b4b-4818-876e-f40f3fc1971b', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'cca4f4a7-b3c2-45d4-8034-dfba20158d68'),
('f17742b3-15be-4e18-9983-7dbb4520ccaf', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'cca4f4a7-b3c2-45d4-8034-dfba20158d68'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '3dabe931-8924-440e-866f-0d4b49827f15'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e2725a2c-9249-48bb-8702-3b01772a1c03');

-- --------------------------------------------------------

--
-- Table structure for table `PROTOCOL_MAPPER_CONFIG`
--

CREATE TABLE `PROTOCOL_MAPPER_CONFIG` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PROTOCOL_MAPPER_CONFIG`
--

INSERT INTO `PROTOCOL_MAPPER_CONFIG` (`PROTOCOL_MAPPER_ID`, `VALUE`, `NAME`) VALUES
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'true', 'access.token.claim'),
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'preferred_username', 'claim.name'),
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'true', 'id.token.claim'),
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'String', 'jsonType.label'),
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'username', 'user.attribute'),
('000a5407-d6ec-4128-ae1c-4a5d27401d66', 'true', 'userinfo.token.claim'),
('022f9c0e-da32-4dbd-84fe-fe93b956083a', 'true', 'access.token.claim'),
('022f9c0e-da32-4dbd-84fe-fe93b956083a', 'resource_access.${client_id}.roles', 'claim.name'),
('022f9c0e-da32-4dbd-84fe-fe93b956083a', 'String', 'jsonType.label'),
('022f9c0e-da32-4dbd-84fe-fe93b956083a', 'true', 'multivalued'),
('022f9c0e-da32-4dbd-84fe-fe93b956083a', 'foo', 'user.attribute'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'true', 'access.token.claim'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'email', 'claim.name'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'true', 'id.token.claim'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'String', 'jsonType.label'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'email', 'user.attribute'),
('028a7b17-0c7b-4120-8ecb-792621eb88a6', 'true', 'userinfo.token.claim'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'true', 'access.token.claim'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'preferred_username', 'claim.name'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'true', 'id.token.claim'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'String', 'jsonType.label'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'username', 'user.attribute'),
('0424f4fc-c228-4402-8de4-fb2c74445e97', 'true', 'userinfo.token.claim'),
('0996473f-773e-446f-b798-b0144023ce6c', 'true', 'access.token.claim'),
('0996473f-773e-446f-b798-b0144023ce6c', 'locale', 'claim.name'),
('0996473f-773e-446f-b798-b0144023ce6c', 'true', 'id.token.claim'),
('0996473f-773e-446f-b798-b0144023ce6c', 'String', 'jsonType.label'),
('0996473f-773e-446f-b798-b0144023ce6c', 'locale', 'user.attribute'),
('0996473f-773e-446f-b798-b0144023ce6c', 'true', 'userinfo.token.claim'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'true', 'access.token.claim'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'locale', 'claim.name'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'true', 'id.token.claim'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'String', 'jsonType.label'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'locale', 'user.attribute'),
('1184c25f-4041-4289-abc8-9317b4492c6a', 'true', 'userinfo.token.claim'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'true', 'access.token.claim'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'phone_number', 'claim.name'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'true', 'id.token.claim'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'String', 'jsonType.label'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'phoneNumber', 'user.attribute'),
('184846af-fadf-4f27-bb0d-9aa6b0f813d7', 'true', 'userinfo.token.claim'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'true', 'access.token.claim'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'clientAddress', 'claim.name'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'true', 'id.token.claim'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'String', 'jsonType.label'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'clientAddress', 'user.session.note'),
('1f68facd-5ff5-420b-bedf-14f4f8a6998f', 'true', 'userinfo.token.claim'),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'true', 'access.token.claim'),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'nickname', 'claim.name'),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'true', 'id.token.claim'),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'String', 'jsonType.label'),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'nickname', 'user.attribute'),
('271a6fda-21e8-4f17-9f26-ec0741cf08f6', 'true', 'userinfo.token.claim'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'true', 'access.token.claim'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'gender', 'claim.name'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'true', 'id.token.claim'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'String', 'jsonType.label'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'gender', 'user.attribute'),
('2eab4dee-0d18-45f0-96c0-9d585e3e319f', 'true', 'userinfo.token.claim'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'true', 'access.token.claim'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'false', 'aggregate.attrs'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'position', 'claim.name'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'true', 'id.token.claim'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'false', 'multivalued'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'position', 'user.attribute'),
('2f008e2b-3d2c-4f80-b4c9-689ea314a3b7', 'true', 'userinfo.token.claim'),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'true', 'access.token.claim'),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'locale', 'claim.name'),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'true', 'id.token.claim'),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'String', 'jsonType.label'),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'locale', 'user.attribute'),
('30d61259-695e-457a-8cd0-00fe9fc7da37', 'true', 'userinfo.token.claim'),
('370cc118-fa35-48e5-b30b-90acb916149c', 'true', 'access.token.claim'),
('370cc118-fa35-48e5-b30b-90acb916149c', 'groups', 'claim.name'),
('370cc118-fa35-48e5-b30b-90acb916149c', 'true', 'id.token.claim'),
('370cc118-fa35-48e5-b30b-90acb916149c', 'String', 'jsonType.label'),
('370cc118-fa35-48e5-b30b-90acb916149c', 'true', 'multivalued'),
('370cc118-fa35-48e5-b30b-90acb916149c', 'foo', 'user.attribute'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'true', 'access.token.claim'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'birthdate', 'claim.name'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'true', 'id.token.claim'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'String', 'jsonType.label'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'birthdate', 'user.attribute'),
('377654e4-fdf7-459d-a840-13f69d5dbd90', 'true', 'userinfo.token.claim'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'true', 'access.token.claim'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'updated_at', 'claim.name'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'true', 'id.token.claim'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'long', 'jsonType.label'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'updatedAt', 'user.attribute'),
('42ee9e98-5f83-48a6-9e79-0498937fec2c', 'true', 'userinfo.token.claim'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'true', 'access.token.claim'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'clientHost', 'claim.name'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'true', 'id.token.claim'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'String', 'jsonType.label'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'clientHost', 'user.session.note'),
('46f0fbfe-9014-421d-bb97-168c0faf9925', 'true', 'userinfo.token.claim'),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'true', 'access.token.claim'),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'zoneinfo', 'claim.name'),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'true', 'id.token.claim'),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'String', 'jsonType.label'),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'zoneinfo', 'user.attribute'),
('4d17b47f-8813-4b9f-a698-fb3edb20919b', 'true', 'userinfo.token.claim'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'true', 'access.token.claim'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'true', 'id.token.claim'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'country', 'user.attribute.country'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'formatted', 'user.attribute.formatted'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'locality', 'user.attribute.locality'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'postal_code', 'user.attribute.postal_code'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'region', 'user.attribute.region'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'street', 'user.attribute.street'),
('4dd4fae6-b137-4a02-abbf-6aaf15690446', 'true', 'userinfo.token.claim'),
('5298e884-ffd5-4cd2-bfea-58854586451e', 'Role', 'attribute.name'),
('5298e884-ffd5-4cd2-bfea-58854586451e', 'Basic', 'attribute.nameformat'),
('5298e884-ffd5-4cd2-bfea-58854586451e', 'false', 'single'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'true', 'access.token.claim'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'false', 'aggregate.attrs'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'dept', 'claim.name'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'true', 'id.token.claim'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'false', 'multivalued'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'dept', 'user.attribute'),
('52ed473c-310f-4445-ba47-d90fa1c3cf11', 'true', 'userinfo.token.claim'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'true', 'access.token.claim'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'website', 'claim.name'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'true', 'id.token.claim'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'String', 'jsonType.label'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'website', 'user.attribute'),
('584a4a0e-1286-4f06-a27d-7a50288305c1', 'true', 'userinfo.token.claim'),
('5c988329-0f8f-4e54-a83d-561d5f48e64e', 'true', 'access.token.claim'),
('5c988329-0f8f-4e54-a83d-561d5f48e64e', 'true', 'id.token.claim'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'true', 'access.token.claim'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'middle_name', 'claim.name'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'true', 'id.token.claim'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'String', 'jsonType.label'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'middleName', 'user.attribute'),
('5e87b2eb-67d7-49b7-bcb7-2872d6f7970a', 'true', 'userinfo.token.claim'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'true', 'access.token.claim'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'email_verified', 'claim.name'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'true', 'id.token.claim'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'boolean', 'jsonType.label'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'emailVerified', 'user.attribute'),
('5f4dec39-3458-42c7-87bb-c2fec7a10192', 'true', 'userinfo.token.claim'),
('6412a264-e630-4a28-b893-f1c715036c7a', 'true', 'access.token.claim'),
('6412a264-e630-4a28-b893-f1c715036c7a', 'true', 'id.token.claim'),
('6412a264-e630-4a28-b893-f1c715036c7a', 'true', 'userinfo.token.claim'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'true', 'access.token.claim'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'updated_at', 'claim.name'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'true', 'id.token.claim'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'long', 'jsonType.label'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'updatedAt', 'user.attribute'),
('6de61ad5-003d-405c-b6eb-0102ad3254cf', 'true', 'userinfo.token.claim'),
('73311ba9-c54f-4974-afed-10aa30116055', 'true', 'access.token.claim'),
('73311ba9-c54f-4974-afed-10aa30116055', 'locale', 'claim.name'),
('73311ba9-c54f-4974-afed-10aa30116055', 'true', 'id.token.claim'),
('73311ba9-c54f-4974-afed-10aa30116055', 'String', 'jsonType.label'),
('73311ba9-c54f-4974-afed-10aa30116055', 'locale', 'user.attribute'),
('73311ba9-c54f-4974-afed-10aa30116055', 'true', 'userinfo.token.claim'),
('7942782e-b976-4fbb-855f-94e5507048b9', 'true', 'access.token.claim'),
('7942782e-b976-4fbb-855f-94e5507048b9', 'phone_number_verified', 'claim.name'),
('7942782e-b976-4fbb-855f-94e5507048b9', 'true', 'id.token.claim'),
('7942782e-b976-4fbb-855f-94e5507048b9', 'boolean', 'jsonType.label'),
('7942782e-b976-4fbb-855f-94e5507048b9', 'phoneNumberVerified', 'user.attribute'),
('7942782e-b976-4fbb-855f-94e5507048b9', 'true', 'userinfo.token.claim'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'true', 'access.token.claim'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'nickname', 'claim.name'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'true', 'id.token.claim'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'String', 'jsonType.label'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'nickname', 'user.attribute'),
('7c6bd00a-aeeb-47ea-b4ea-e5a7698eb2a5', 'true', 'userinfo.token.claim'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'true', 'access.token.claim'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'email_verified', 'claim.name'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'true', 'id.token.claim'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'boolean', 'jsonType.label'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'emailVerified', 'user.attribute'),
('7e6ada31-b92a-4f69-843e-3b951c8e2b93', 'true', 'userinfo.token.claim'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'true', 'access.token.claim'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'clientId', 'claim.name'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'true', 'id.token.claim'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'String', 'jsonType.label'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'clientId', 'user.session.note'),
('814e3292-00ac-45d2-b32e-6bc78bd64a84', 'true', 'userinfo.token.claim'),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'true', 'access.token.claim'),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'profile', 'claim.name'),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'true', 'id.token.claim'),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'String', 'jsonType.label'),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'profile', 'user.attribute'),
('83c540ac-5bed-4ee6-ab4e-9c78b29319b7', 'true', 'userinfo.token.claim'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'true', 'access.token.claim'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'birthdate', 'claim.name'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'true', 'id.token.claim'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'String', 'jsonType.label'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'birthdate', 'user.attribute'),
('8c93d0bb-25bd-4e70-886f-726f7a9c2103', 'true', 'userinfo.token.claim'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'true', 'access.token.claim'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'upn', 'claim.name'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'true', 'id.token.claim'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'String', 'jsonType.label'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'username', 'user.attribute'),
('91540b5e-9e7e-4ea1-9b67-f7274fc5c70d', 'true', 'userinfo.token.claim'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'true', 'access.token.claim'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'clientId', 'claim.name'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'true', 'id.token.claim'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'String', 'jsonType.label'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'clientId', 'user.session.note'),
('93da46f2-60e6-467c-aa63-f241519b008c', 'true', 'userinfo.token.claim'),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'true', 'access.token.claim'),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'given_name', 'claim.name'),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'true', 'id.token.claim'),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'String', 'jsonType.label'),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'firstName', 'user.attribute'),
('9779e2f8-d5b9-4102-bb24-47e5edab77b9', 'true', 'userinfo.token.claim'),
('9f340e36-68d7-40d7-ba52-f4dc1013241c', 'true', 'access.token.claim'),
('9f340e36-68d7-40d7-ba52-f4dc1013241c', 'true', 'id.token.claim'),
('9f340e36-68d7-40d7-ba52-f4dc1013241c', 'true', 'userinfo.token.claim'),
('a29b40af-95b0-469f-948e-0b1383028bea', 'true', 'access.token.claim'),
('a29b40af-95b0-469f-948e-0b1383028bea', 'upn', 'claim.name'),
('a29b40af-95b0-469f-948e-0b1383028bea', 'true', 'id.token.claim'),
('a29b40af-95b0-469f-948e-0b1383028bea', 'String', 'jsonType.label'),
('a29b40af-95b0-469f-948e-0b1383028bea', 'username', 'user.attribute'),
('a29b40af-95b0-469f-948e-0b1383028bea', 'true', 'userinfo.token.claim'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'true', 'access.token.claim'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'picture', 'claim.name'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'true', 'id.token.claim'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'String', 'jsonType.label'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'picture', 'user.attribute'),
('a8c92710-b924-4eda-af5f-f648d1ee0bbc', 'true', 'userinfo.token.claim'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'true', 'access.token.claim'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'zoneinfo', 'claim.name'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'true', 'id.token.claim'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'String', 'jsonType.label'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'zoneinfo', 'user.attribute'),
('a9f1170d-920e-4fbb-b9dd-27f48130fb2e', 'true', 'userinfo.token.claim'),
('aac23750-4b05-43ae-8edd-b00a176c049b', 'Role', 'attribute.name'),
('aac23750-4b05-43ae-8edd-b00a176c049b', 'Basic', 'attribute.nameformat'),
('aac23750-4b05-43ae-8edd-b00a176c049b', 'false', 'single'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'true', 'access.token.claim'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'groups', 'claim.name'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'true', 'id.token.claim'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'String', 'jsonType.label'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'true', 'multivalued'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'foo', 'user.attribute'),
('acfe92d7-e72b-4e63-92c7-5a18a84536ea', 'true', 'userinfo.token.claim'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'true', 'access.token.claim'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'true', 'id.token.claim'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'country', 'user.attribute.country'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'formatted', 'user.attribute.formatted'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'locality', 'user.attribute.locality'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'postal_code', 'user.attribute.postal_code'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'region', 'user.attribute.region'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'street', 'user.attribute.street'),
('adf4653c-c7b0-4e6b-990d-a154450934dc', 'true', 'userinfo.token.claim'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'true', 'access.token.claim'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'clientAddress', 'claim.name'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'true', 'id.token.claim'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'String', 'jsonType.label'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'clientAddress', 'user.session.note'),
('b3ce80e8-274e-4ba4-89ab-1528f346fb3e', 'true', 'userinfo.token.claim'),
('baefe8fe-2de8-4b17-a62a-afcc6e7817be', 'true', 'access.token.claim'),
('baefe8fe-2de8-4b17-a62a-afcc6e7817be', 'realm_access.roles', 'claim.name'),
('baefe8fe-2de8-4b17-a62a-afcc6e7817be', 'String', 'jsonType.label'),
('baefe8fe-2de8-4b17-a62a-afcc6e7817be', 'true', 'multivalued'),
('baefe8fe-2de8-4b17-a62a-afcc6e7817be', 'foo', 'user.attribute'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'true', 'access.token.claim'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'profile', 'claim.name'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'true', 'id.token.claim'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'String', 'jsonType.label'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'profile', 'user.attribute'),
('bc45926f-2aad-4b06-92e0-06a2e2af6904', 'true', 'userinfo.token.claim'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'true', 'access.token.claim'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'gender', 'claim.name'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'true', 'id.token.claim'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'String', 'jsonType.label'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'gender', 'user.attribute'),
('be41ec7d-9ea4-4d5e-915f-5d013c7507d0', 'true', 'userinfo.token.claim'),
('c11c054b-2648-4424-92ac-257d76da818e', 'true', 'access.token.claim'),
('c11c054b-2648-4424-92ac-257d76da818e', 'family_name', 'claim.name'),
('c11c054b-2648-4424-92ac-257d76da818e', 'true', 'id.token.claim'),
('c11c054b-2648-4424-92ac-257d76da818e', 'String', 'jsonType.label'),
('c11c054b-2648-4424-92ac-257d76da818e', 'lastName', 'user.attribute'),
('c11c054b-2648-4424-92ac-257d76da818e', 'true', 'userinfo.token.claim'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'true', 'access.token.claim'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'email', 'claim.name'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'true', 'id.token.claim'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'String', 'jsonType.label'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'email', 'user.attribute'),
('c4783b85-178e-4e87-b72a-957eed1389a6', 'true', 'userinfo.token.claim'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'true', 'access.token.claim'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'family_name', 'claim.name'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'true', 'id.token.claim'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'String', 'jsonType.label'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'lastName', 'user.attribute'),
('cb4c511f-cc20-4901-9b59-12fa366977bd', 'true', 'userinfo.token.claim'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'true', 'access.token.claim'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'picture', 'claim.name'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'true', 'id.token.claim'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'String', 'jsonType.label'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'picture', 'user.attribute'),
('dd8439a8-84fb-488a-b739-15acea802adf', 'true', 'userinfo.token.claim'),
('de39b4d5-2e83-414d-87eb-543126eefcfe', 'true', 'access.token.claim'),
('de39b4d5-2e83-414d-87eb-543126eefcfe', 'true', 'id.token.claim'),
('de39b4d5-2e83-414d-87eb-543126eefcfe', 'true', 'userinfo.token.claim'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'true', 'access.token.claim'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'middle_name', 'claim.name'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'true', 'id.token.claim'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'String', 'jsonType.label'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'middleName', 'user.attribute'),
('de446e03-ed8c-4302-97a5-3623a986bd83', 'true', 'userinfo.token.claim'),
('deecd0d8-3146-458e-bc93-38061720c7c9', 'true', 'access.token.claim'),
('deecd0d8-3146-458e-bc93-38061720c7c9', 'realm_access.roles', 'claim.name'),
('deecd0d8-3146-458e-bc93-38061720c7c9', 'String', 'jsonType.label'),
('deecd0d8-3146-458e-bc93-38061720c7c9', 'true', 'multivalued'),
('deecd0d8-3146-458e-bc93-38061720c7c9', 'foo', 'user.attribute'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'true', 'access.token.claim'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'clientHost', 'claim.name'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'true', 'id.token.claim'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'String', 'jsonType.label'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'clientHost', 'user.session.note'),
('dfc32fcb-6374-4813-b318-b6157ae996ce', 'true', 'userinfo.token.claim'),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'true', 'access.token.claim'),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'website', 'claim.name'),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'true', 'id.token.claim'),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'String', 'jsonType.label'),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'website', 'user.attribute'),
('e044bba1-15dc-4efb-96a2-29c3fe6d26fe', 'true', 'userinfo.token.claim'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'true', 'access.token.claim'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'phone_number_verified', 'claim.name'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'true', 'id.token.claim'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'boolean', 'jsonType.label'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'phoneNumberVerified', 'user.attribute'),
('e164764b-8841-4c8d-b83a-f00105794a0d', 'true', 'userinfo.token.claim'),
('e8b6ccd6-0b4b-4818-876e-f40f3fc1971b', 'true', 'access.token.claim'),
('e8b6ccd6-0b4b-4818-876e-f40f3fc1971b', 'resource_access.${client_id}.roles', 'claim.name'),
('e8b6ccd6-0b4b-4818-876e-f40f3fc1971b', 'String', 'jsonType.label'),
('e8b6ccd6-0b4b-4818-876e-f40f3fc1971b', 'true', 'multivalued'),
('e8b6ccd6-0b4b-4818-876e-f40f3fc1971b', 'foo', 'user.attribute'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'true', 'access.token.claim'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'given_name', 'claim.name'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'true', 'id.token.claim'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'String', 'jsonType.label'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'firstName', 'user.attribute'),
('fc4e7497-a18f-453e-b85d-1cec3c6c0e82', 'true', 'userinfo.token.claim'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'true', 'access.token.claim'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'phone_number', 'claim.name'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'true', 'id.token.claim'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'String', 'jsonType.label'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'phoneNumber', 'user.attribute'),
('fc8e95d4-0c34-4189-9ea6-de4959d467ce', 'true', 'userinfo.token.claim');

-- --------------------------------------------------------

--
-- Table structure for table `REALM`
--

CREATE TABLE `REALM` (
  `ID` varchar(36) NOT NULL,
  `ACCESS_CODE_LIFESPAN` int(11) DEFAULT NULL,
  `USER_ACTION_LIFESPAN` int(11) DEFAULT NULL,
  `ACCESS_TOKEN_LIFESPAN` int(11) DEFAULT NULL,
  `ACCOUNT_THEME` varchar(255) DEFAULT NULL,
  `ADMIN_THEME` varchar(255) DEFAULT NULL,
  `EMAIL_THEME` varchar(255) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_EXPIRATION` bigint(20) DEFAULT NULL,
  `LOGIN_THEME` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) DEFAULT NULL,
  `PASSWORD_POLICY` varchar(2550) DEFAULT NULL,
  `REGISTRATION_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `RESET_PASSWORD_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `SOCIAL` bit(1) NOT NULL DEFAULT b'0',
  `SSL_REQUIRED` varchar(255) DEFAULT NULL,
  `SSO_IDLE_TIMEOUT` int(11) DEFAULT NULL,
  `SSO_MAX_LIFESPAN` int(11) DEFAULT NULL,
  `UPDATE_PROFILE_ON_SOC_LOGIN` bit(1) NOT NULL DEFAULT b'0',
  `VERIFY_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `MASTER_ADMIN_CLIENT` varchar(36) DEFAULT NULL,
  `LOGIN_LIFESPAN` int(11) DEFAULT NULL,
  `INTERNATIONALIZATION_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_LOCALE` varchar(255) DEFAULT NULL,
  `REG_EMAIL_AS_USERNAME` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_DETAILS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EDIT_USERNAME_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `OTP_POLICY_COUNTER` int(11) DEFAULT '0',
  `OTP_POLICY_WINDOW` int(11) DEFAULT '1',
  `OTP_POLICY_PERIOD` int(11) DEFAULT '30',
  `OTP_POLICY_DIGITS` int(11) DEFAULT '6',
  `OTP_POLICY_ALG` varchar(36) DEFAULT 'HmacSHA1',
  `OTP_POLICY_TYPE` varchar(36) DEFAULT 'totp',
  `BROWSER_FLOW` varchar(36) DEFAULT NULL,
  `REGISTRATION_FLOW` varchar(36) DEFAULT NULL,
  `DIRECT_GRANT_FLOW` varchar(36) DEFAULT NULL,
  `RESET_CREDENTIALS_FLOW` varchar(36) DEFAULT NULL,
  `CLIENT_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `OFFLINE_SESSION_IDLE_TIMEOUT` int(11) DEFAULT '0',
  `REVOKE_REFRESH_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `ACCESS_TOKEN_LIFE_IMPLICIT` int(11) DEFAULT '0',
  `LOGIN_WITH_EMAIL_ALLOWED` bit(1) NOT NULL DEFAULT b'1',
  `DUPLICATE_EMAILS_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `DOCKER_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `REFRESH_TOKEN_MAX_REUSE` int(11) DEFAULT '0',
  `ALLOW_USER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `SSO_MAX_LIFESPAN_REMEMBER_ME` int(11) NOT NULL,
  `SSO_IDLE_TIMEOUT_REMEMBER_ME` int(11) NOT NULL,
  `DEFAULT_ROLE` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REALM`
--

INSERT INTO `REALM` (`ID`, `ACCESS_CODE_LIFESPAN`, `USER_ACTION_LIFESPAN`, `ACCESS_TOKEN_LIFESPAN`, `ACCOUNT_THEME`, `ADMIN_THEME`, `EMAIL_THEME`, `ENABLED`, `EVENTS_ENABLED`, `EVENTS_EXPIRATION`, `LOGIN_THEME`, `NAME`, `NOT_BEFORE`, `PASSWORD_POLICY`, `REGISTRATION_ALLOWED`, `REMEMBER_ME`, `RESET_PASSWORD_ALLOWED`, `SOCIAL`, `SSL_REQUIRED`, `SSO_IDLE_TIMEOUT`, `SSO_MAX_LIFESPAN`, `UPDATE_PROFILE_ON_SOC_LOGIN`, `VERIFY_EMAIL`, `MASTER_ADMIN_CLIENT`, `LOGIN_LIFESPAN`, `INTERNATIONALIZATION_ENABLED`, `DEFAULT_LOCALE`, `REG_EMAIL_AS_USERNAME`, `ADMIN_EVENTS_ENABLED`, `ADMIN_EVENTS_DETAILS_ENABLED`, `EDIT_USERNAME_ALLOWED`, `OTP_POLICY_COUNTER`, `OTP_POLICY_WINDOW`, `OTP_POLICY_PERIOD`, `OTP_POLICY_DIGITS`, `OTP_POLICY_ALG`, `OTP_POLICY_TYPE`, `BROWSER_FLOW`, `REGISTRATION_FLOW`, `DIRECT_GRANT_FLOW`, `RESET_CREDENTIALS_FLOW`, `CLIENT_AUTH_FLOW`, `OFFLINE_SESSION_IDLE_TIMEOUT`, `REVOKE_REFRESH_TOKEN`, `ACCESS_TOKEN_LIFE_IMPLICIT`, `LOGIN_WITH_EMAIL_ALLOWED`, `DUPLICATE_EMAILS_ALLOWED`, `DOCKER_AUTH_FLOW`, `REFRESH_TOKEN_MAX_REUSE`, `ALLOW_USER_MANAGED_ACCESS`, `SSO_MAX_LIFESPAN_REMEMBER_ME`, `SSO_IDLE_TIMEOUT_REMEMBER_ME`, `DEFAULT_ROLE`) VALUES
('ad3a9024-ffab-4299-a385-b777720941f3', 60, 300, 60, NULL, NULL, NULL, b'1', b'0', 0, NULL, 'master', 0, NULL, b'0', b'0', b'0', b'0', 'EXTERNAL', 1800, 36000, b'0', b'0', '79b1f5f9-2227-4a36-ad90-22d1d8643de4', 1800, b'0', NULL, b'0', b'0', b'0', b'0', 0, 1, 30, 6, 'HmacSHA1', 'totp', '60620ae7-7fb4-422a-9a49-8ea356674734', '8552568a-ae87-494a-82d5-8642deb289c1', 'f83dbc35-cd12-48ec-b2dd-11fd277345b3', 'f03744cd-5a6e-4169-a4f1-a4303b83336e', 'e6a5cece-1c9b-4093-956b-0edb43f740b9', 2592000, b'0', 900, b'1', b'0', '6f11ed35-967b-4132-ba1a-8c26f5517a30', 0, b'0', 0, 0, '9ffdde51-ca66-4a03-bb03-94d2655f81bd'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 60, 300, 300, NULL, NULL, NULL, b'1', b'0', 0, NULL, 'demo', 0, NULL, b'0', b'1', b'1', b'0', 'NONE', 18000, 36000, b'0', b'1', '40b87195-caf9-4928-89c6-ade363ef452e', 1800, b'0', NULL, b'0', b'0', b'0', b'0', 0, 1, 30, 6, 'HmacSHA1', 'totp', '19f228f3-6ce7-4ac0-93e1-4381219fc7e8', '6b26c06e-4f90-4a3d-8db4-f83f6bb7f71c', '66c90ce5-99dd-4cfe-84b9-23aa0257a9cb', '00f7c37a-0aa6-4910-b323-99ce02cc6585', '020df459-1d47-4349-99f9-0cb7301cbe50', 2592000, b'0', 900, b'1', b'0', 'ffc73324-12f5-4817-8c69-0b6aa319d2c2', 0, b'0', 0, 0, 'c7fee8d0-eecd-4f6b-801f-a9e02dbedf85');

-- --------------------------------------------------------

--
-- Table structure for table `REALM_ATTRIBUTE`
--

CREATE TABLE `REALM_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REALM_ATTRIBUTE`
--

INSERT INTO `REALM_ATTRIBUTE` (`NAME`, `REALM_ID`, `VALUE`) VALUES
('acr.loa.map', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '[]'),
('actionTokenGeneratedByAdminLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '43200'),
('actionTokenGeneratedByUserLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '300'),
('bruteForceProtected', 'ad3a9024-ffab-4299-a385-b777720941f3', 'false'),
('bruteForceProtected', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'false'),
('cibaAuthRequestedUserHint', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'login_hint'),
('cibaBackchannelTokenDeliveryMode', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'poll'),
('cibaExpiresIn', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '120'),
('cibaInterval', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5'),
('client-policies.policies', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '{\"policies\":[]}'),
('client-policies.profiles', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '{\"profiles\":[]}'),
('clientOfflineSessionIdleTimeout', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '0'),
('clientOfflineSessionMaxLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '0'),
('clientSessionIdleTimeout', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '0'),
('clientSessionMaxLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '0'),
('defaultSignatureAlgorithm', 'ad3a9024-ffab-4299-a385-b777720941f3', 'RS256'),
('defaultSignatureAlgorithm', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'RS256'),
('displayName', 'ad3a9024-ffab-4299-a385-b777720941f3', 'Keycloak'),
('displayName', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'Ecosystem'),
('displayNameHtml', 'ad3a9024-ffab-4299-a385-b777720941f3', '<div class=\"kc-logo-text\"><span>Keycloak</span></div>'),
('displayNameHtml', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '<div class=\"kc-logo-text\"><span>DMS</span></div>'),
('failureFactor', 'ad3a9024-ffab-4299-a385-b777720941f3', '30'),
('failureFactor', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '30'),
('frontendUrl', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', ''),
('maxDeltaTimeSeconds', 'ad3a9024-ffab-4299-a385-b777720941f3', '43200'),
('maxDeltaTimeSeconds', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '43200'),
('maxFailureWaitSeconds', 'ad3a9024-ffab-4299-a385-b777720941f3', '900'),
('maxFailureWaitSeconds', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '900'),
('minimumQuickLoginWaitSeconds', 'ad3a9024-ffab-4299-a385-b777720941f3', '60'),
('minimumQuickLoginWaitSeconds', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '60'),
('oauth2DeviceCodeLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '600'),
('oauth2DevicePollingInterval', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5'),
('offlineSessionMaxLifespan', 'ad3a9024-ffab-4299-a385-b777720941f3', '5184000'),
('offlineSessionMaxLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '5184000'),
('offlineSessionMaxLifespanEnabled', 'ad3a9024-ffab-4299-a385-b777720941f3', 'false'),
('offlineSessionMaxLifespanEnabled', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'false'),
('parRequestUriLifespan', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '60'),
('permanentLockout', 'ad3a9024-ffab-4299-a385-b777720941f3', 'false'),
('permanentLockout', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'false'),
('quickLoginCheckMilliSeconds', 'ad3a9024-ffab-4299-a385-b777720941f3', '1000'),
('quickLoginCheckMilliSeconds', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '1000'),
('userProfileEnabled', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'true'),
('waitIncrementSeconds', 'ad3a9024-ffab-4299-a385-b777720941f3', '60'),
('waitIncrementSeconds', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '60'),
('webAuthnPolicyAttestationConveyancePreference', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyAttestationConveyancePreferencePasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyAuthenticatorAttachment', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyAuthenticatorAttachmentPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyAvoidSameAuthenticatorRegister', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'false'),
('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'false'),
('webAuthnPolicyCreateTimeout', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '0'),
('webAuthnPolicyCreateTimeoutPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '0'),
('webAuthnPolicyRequireResidentKey', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyRequireResidentKeyPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyRpEntityName', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'keycloak'),
('webAuthnPolicyRpEntityNamePasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'keycloak'),
('webAuthnPolicyRpId', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', ''),
('webAuthnPolicyRpIdPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', ''),
('webAuthnPolicySignatureAlgorithms', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ES256'),
('webAuthnPolicySignatureAlgorithmsPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'ES256'),
('webAuthnPolicyUserVerificationRequirement', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('webAuthnPolicyUserVerificationRequirementPasswordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'not specified'),
('_browser_header.contentSecurityPolicy', 'ad3a9024-ffab-4299-a385-b777720941f3', 'frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),
('_browser_header.contentSecurityPolicy', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),
('_browser_header.contentSecurityPolicyReportOnly', 'ad3a9024-ffab-4299-a385-b777720941f3', ''),
('_browser_header.contentSecurityPolicyReportOnly', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', ''),
('_browser_header.strictTransportSecurity', 'ad3a9024-ffab-4299-a385-b777720941f3', 'max-age=31536000; includeSubDomains'),
('_browser_header.strictTransportSecurity', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'max-age=31536000; includeSubDomains'),
('_browser_header.xContentTypeOptions', 'ad3a9024-ffab-4299-a385-b777720941f3', 'nosniff'),
('_browser_header.xContentTypeOptions', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'nosniff'),
('_browser_header.xFrameOptions', 'ad3a9024-ffab-4299-a385-b777720941f3', 'SAMEORIGIN'),
('_browser_header.xFrameOptions', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'SAMEORIGIN'),
('_browser_header.xRobotsTag', 'ad3a9024-ffab-4299-a385-b777720941f3', 'none'),
('_browser_header.xRobotsTag', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'none'),
('_browser_header.xXSSProtection', 'ad3a9024-ffab-4299-a385-b777720941f3', '1; mode=block'),
('_browser_header.xXSSProtection', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '1; mode=block');

-- --------------------------------------------------------

--
-- Table structure for table `REALM_DEFAULT_GROUPS`
--

CREATE TABLE `REALM_DEFAULT_GROUPS` (
  `REALM_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `REALM_ENABLED_EVENT_TYPES`
--

CREATE TABLE `REALM_ENABLED_EVENT_TYPES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `REALM_EVENTS_LISTENERS`
--

CREATE TABLE `REALM_EVENTS_LISTENERS` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REALM_EVENTS_LISTENERS`
--

INSERT INTO `REALM_EVENTS_LISTENERS` (`REALM_ID`, `VALUE`) VALUES
('ad3a9024-ffab-4299-a385-b777720941f3', 'jboss-logging'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'jboss-logging');

-- --------------------------------------------------------

--
-- Table structure for table `REALM_LOCALIZATIONS`
--

CREATE TABLE `REALM_LOCALIZATIONS` (
  `REALM_ID` varchar(255) NOT NULL,
  `LOCALE` varchar(255) NOT NULL,
  `TEXTS` longtext CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `REALM_REQUIRED_CREDENTIAL`
--

CREATE TABLE `REALM_REQUIRED_CREDENTIAL` (
  `TYPE` varchar(255) NOT NULL,
  `FORM_LABEL` varchar(255) DEFAULT NULL,
  `INPUT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REALM_REQUIRED_CREDENTIAL`
--

INSERT INTO `REALM_REQUIRED_CREDENTIAL` (`TYPE`, `FORM_LABEL`, `INPUT`, `SECRET`, `REALM_ID`) VALUES
('password', 'password', b'1', b'1', 'ad3a9024-ffab-4299-a385-b777720941f3'),
('password', 'password', b'1', b'1', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf');

-- --------------------------------------------------------

--
-- Table structure for table `REALM_SMTP_CONFIG`
--

CREATE TABLE `REALM_SMTP_CONFIG` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REALM_SMTP_CONFIG`
--

INSERT INTO `REALM_SMTP_CONFIG` (`REALM_ID`, `VALUE`, `NAME`) VALUES
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'true', 'auth'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '', 'envelopeFrom'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'mailsys123@gmail.com', 'from'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'Grooo Mail System', 'fromDisplayName'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'smtp.gmail.com', 'host'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'xjycacffgwtwhczp', 'password'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '465', 'port'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '', 'replyTo'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', '', 'replyToDisplayName'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'true', 'ssl'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'true', 'starttls'),
('ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'mailsys123@gmail.com', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `REALM_SUPPORTED_LOCALES`
--

CREATE TABLE `REALM_SUPPORTED_LOCALES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `REDIRECT_URIS`
--

CREATE TABLE `REDIRECT_URIS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REDIRECT_URIS`
--

INSERT INTO `REDIRECT_URIS` (`CLIENT_ID`, `VALUE`) VALUES
('4acd89d8-9537-4d58-8486-df058afeaaeb', '/admin/demo/console/*'),
('4cc70347-b41c-4f63-8428-706b68bba5d7', '/realms/demo/account/*'),
('67d45f4e-c19e-41a4-861a-43479d57f913', 'http://localhost:3001/*'),
('68c51fb6-dfff-40f6-9e26-9464e60b6894', 'http://127.0.0.1:3002/*'),
('77a90979-ac34-4353-9700-11005d688749', '/admin/master/console/*'),
('93d1aafa-52f7-4a4b-80e2-8fd2bae0a654', 'http://127.0.0.1:3000/*'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', '/realms/master/account/*'),
('aaef7869-4756-4677-ad53-16a60aadc460', '/realms/demo/account/*'),
('ebefc576-4a5e-4f3d-ac9f-9e59dbe3dea5', '/realms/master/account/*');

-- --------------------------------------------------------

--
-- Table structure for table `REQUIRED_ACTION_CONFIG`
--

CREATE TABLE `REQUIRED_ACTION_CONFIG` (
  `REQUIRED_ACTION_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `REQUIRED_ACTION_PROVIDER`
--

CREATE TABLE `REQUIRED_ACTION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_ACTION` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REQUIRED_ACTION_PROVIDER`
--

INSERT INTO `REQUIRED_ACTION_PROVIDER` (`ID`, `ALIAS`, `NAME`, `REALM_ID`, `ENABLED`, `DEFAULT_ACTION`, `PROVIDER_ID`, `PRIORITY`) VALUES
('17026847-07bc-4822-8465-2e73c86cd9a1', 'update_user_locale', 'Update User Locale', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'update_user_locale', 1000),
('1e70a7c8-2342-443a-87c3-0cae3dc304cc', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'webauthn-register-passwordless', 80),
('21b654c4-cea9-4c4e-a2d0-a82c6524924b', 'VERIFY_EMAIL', 'Verify Email', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'VERIFY_EMAIL', 50),
('354cc0bd-c6c2-4280-aaf3-1803866b4d47', 'CONFIGURE_TOTP', 'Configure OTP', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'CONFIGURE_TOTP', 10),
('38249162-16d6-4f69-8390-a6aa232b782b', 'CONFIGURE_TOTP', 'Configure OTP', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'CONFIGURE_TOTP', 10),
('568c053a-e984-4a6b-a547-b313b450657b', 'webauthn-register', 'Webauthn Register', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'webauthn-register', 70),
('59279d4e-76c4-451a-aad2-eea5e795edd8', 'delete_account', 'Delete Account', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', b'0', 'delete_account', 60),
('5d3ee194-12cb-454f-b34e-d0ded1b973f7', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'webauthn-register-passwordless', 80),
('5e196c56-33f5-4fe0-86d5-fb41cb969e2a', 'webauthn-register', 'Webauthn Register', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'webauthn-register', 70),
('77fcc369-0c7a-40f5-8c42-bb8d8e2d7965', 'VERIFY_PROFILE', 'Verify Profile', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', b'0', 'VERIFY_PROFILE', 1001),
('962eea77-d80e-4380-ae5e-5b4946ac2f6a', 'UPDATE_PROFILE', 'Update Profile', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'UPDATE_PROFILE', 40),
('9a06ca57-23c7-4b9f-8704-4902d8ae6012', 'terms_and_conditions', 'Terms and Conditions', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', b'0', 'terms_and_conditions', 20),
('9b4a663e-be84-4e52-bf6f-1f8d21310abc', 'delete_account', 'Delete Account', 'ad3a9024-ffab-4299-a385-b777720941f3', b'0', b'0', 'delete_account', 60),
('9fb9cc02-0324-4a50-9e06-81d64e2b3559', 'UPDATE_PROFILE', 'Update Profile', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'UPDATE_PROFILE', 40),
('a66b7a4b-3fd3-43e7-b726-ef31f338afbb', 'terms_and_conditions', 'Terms and Conditions', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'0', b'0', 'terms_and_conditions', 20),
('aa66b76e-9b7b-42df-b1db-f17f56225af6', 'UPDATE_PASSWORD', 'Update Password', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'UPDATE_PASSWORD', 30),
('b88f7b0f-d700-4ed1-89b0-33121ab2bf0c', 'UPDATE_PASSWORD', 'Update Password', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'UPDATE_PASSWORD', 30),
('d519623a-447a-4eee-bca1-5db977605d12', 'VERIFY_EMAIL', 'Verify Email', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', b'1', b'0', 'VERIFY_EMAIL', 50),
('de92a0e2-deb2-4553-83fd-56ef83722d50', 'update_user_locale', 'Update User Locale', 'ad3a9024-ffab-4299-a385-b777720941f3', b'1', b'0', 'update_user_locale', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_ATTRIBUTE`
--

CREATE TABLE `RESOURCE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_POLICY`
--

CREATE TABLE `RESOURCE_POLICY` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESOURCE_POLICY`
--

INSERT INTO `RESOURCE_POLICY` (`RESOURCE_ID`, `POLICY_ID`) VALUES
('1feb43dd-7643-4f08-ad97-63825725dad0', '2936e842-9fdf-456b-bde4-dc64fa59662f'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '3f12391f-1ed5-4f49-a094-8ae2da76ad41'),
('77f65cc9-2cc8-4188-970d-023f245f61a1', '3f9f1b3b-fcba-44f1-947c-ee7ae7bce403'),
('77f65cc9-2cc8-4188-970d-023f245f61a1', '806e2cfc-9d97-487c-8287-dc610e655336'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '9a59a09b-0aa6-46ef-8aee-9387f6c1a364'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '9e43811e-a66d-4185-81d8-b4be1107242d'),
('1feb43dd-7643-4f08-ad97-63825725dad0', 'c8c7beca-55f3-4020-bdf6-61253154009d'),
('1feb43dd-7643-4f08-ad97-63825725dad0', 'ceacac10-57b5-45e5-b704-9fb0ec87e122'),
('77f65cc9-2cc8-4188-970d-023f245f61a1', 'd7b904ec-9b08-4ca1-903b-c9c69e08834c');

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_SCOPE`
--

CREATE TABLE `RESOURCE_SCOPE` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESOURCE_SCOPE`
--

INSERT INTO `RESOURCE_SCOPE` (`RESOURCE_ID`, `SCOPE_ID`) VALUES
('1feb43dd-7643-4f08-ad97-63825725dad0', '1afc67be-93ec-449d-a99d-aecdc5324e1b'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '29180d88-65ec-4c8c-bb0d-a2a0ad3a7068'),
('77f65cc9-2cc8-4188-970d-023f245f61a1', '4c14e59e-67e4-4f4d-adbb-cdc3cbf38164'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '6b82cf11-ed83-422e-bc64-2d685f58fe1c'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '7400ca8e-d5f4-4bbf-a134-63dfc4577d43'),
('1feb43dd-7643-4f08-ad97-63825725dad0', '7a299892-4fc8-4e82-b5bd-bd4d591da8a0'),
('77f65cc9-2cc8-4188-970d-023f245f61a1', 'acb18db7-eaba-499c-bb1b-165fe91bd0d0'),
('1feb43dd-7643-4f08-ad97-63825725dad0', 'ba78fd56-2ba8-4024-b58e-c6058918c402'),
('77f65cc9-2cc8-4188-970d-023f245f61a1', 'ee8c363c-471f-4145-98d5-0451b9af09a4');

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_SERVER`
--

CREATE TABLE `RESOURCE_SERVER` (
  `ID` varchar(36) NOT NULL,
  `ALLOW_RS_REMOTE_MGMT` bit(1) NOT NULL DEFAULT b'0',
  `POLICY_ENFORCE_MODE` varchar(15) NOT NULL,
  `DECISION_STRATEGY` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESOURCE_SERVER`
--

INSERT INTO `RESOURCE_SERVER` (`ID`, `ALLOW_RS_REMOTE_MGMT`, `POLICY_ENFORCE_MODE`, `DECISION_STRATEGY`) VALUES
('343c7912-686d-4e6b-9c15-3ae53698ebfb', b'0', '0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_SERVER_PERM_TICKET`
--

CREATE TABLE `RESOURCE_SERVER_PERM_TICKET` (
  `ID` varchar(36) NOT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `REQUESTER` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint(20) NOT NULL,
  `GRANTED_TIMESTAMP` bigint(20) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_SERVER_POLICY`
--

CREATE TABLE `RESOURCE_SERVER_POLICY` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `DECISION_STRATEGY` varchar(20) DEFAULT NULL,
  `LOGIC` varchar(20) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESOURCE_SERVER_POLICY`
--

INSERT INTO `RESOURCE_SERVER_POLICY` (`ID`, `NAME`, `DESCRIPTION`, `TYPE`, `DECISION_STRATEGY`, `LOGIC`, `RESOURCE_SERVER_ID`, `OWNER`) VALUES
('2936e842-9fdf-456b-bde4-dc64fa59662f', 'map-roles.permission.users', NULL, 'scope', '1', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('3f12391f-1ed5-4f49-a094-8ae2da76ad41', 'view.permission.users', NULL, 'scope', '1', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('3f9f1b3b-fcba-44f1-947c-ee7ae7bce403', 'map-role-client-scope.permission.63477bfb-8646-4d10-b688-8fa49e94527b', NULL, 'scope', '0', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('806e2cfc-9d97-487c-8287-dc610e655336', 'map-role.permission.63477bfb-8646-4d10-b688-8fa49e94527b', NULL, 'scope', '0', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('9a59a09b-0aa6-46ef-8aee-9387f6c1a364', 'manage.permission.users', NULL, 'scope', '1', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('9e43811e-a66d-4185-81d8-b4be1107242d', 'admin-impersonating.permission.users', NULL, 'scope', '1', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('c8c7beca-55f3-4020-bdf6-61253154009d', 'manage-group-membership.permission.users', NULL, 'scope', '1', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('ceacac10-57b5-45e5-b704-9fb0ec87e122', 'user-impersonated.permission.users', NULL, 'scope', '1', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('d7b904ec-9b08-4ca1-903b-c9c69e08834c', 'map-role-composite.permission.63477bfb-8646-4d10-b688-8fa49e94527b', NULL, 'scope', '0', '0', '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_SERVER_RESOURCE`
--

CREATE TABLE `RESOURCE_SERVER_RESOURCE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `DISPLAY_NAME` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESOURCE_SERVER_RESOURCE`
--

INSERT INTO `RESOURCE_SERVER_RESOURCE` (`ID`, `NAME`, `TYPE`, `ICON_URI`, `OWNER`, `RESOURCE_SERVER_ID`, `OWNER_MANAGED_ACCESS`, `DISPLAY_NAME`) VALUES
('1feb43dd-7643-4f08-ad97-63825725dad0', 'Users', NULL, NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'0', NULL),
('77f65cc9-2cc8-4188-970d-023f245f61a1', 'role.resource.63477bfb-8646-4d10-b688-8fa49e94527b', 'Role', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', '343c7912-686d-4e6b-9c15-3ae53698ebfb', b'0', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_SERVER_SCOPE`
--

CREATE TABLE `RESOURCE_SERVER_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RESOURCE_SERVER_SCOPE`
--

INSERT INTO `RESOURCE_SERVER_SCOPE` (`ID`, `NAME`, `ICON_URI`, `RESOURCE_SERVER_ID`, `DISPLAY_NAME`) VALUES
('1afc67be-93ec-449d-a99d-aecdc5324e1b', 'manage-group-membership', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('29180d88-65ec-4c8c-bb0d-a2a0ad3a7068', 'manage', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('4c14e59e-67e4-4f4d-adbb-cdc3cbf38164', 'map-role', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('6b82cf11-ed83-422e-bc64-2d685f58fe1c', 'user-impersonated', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('7400ca8e-d5f4-4bbf-a134-63dfc4577d43', 'view', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('7a299892-4fc8-4e82-b5bd-bd4d591da8a0', 'map-roles', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('aa98a1a2-aa50-4ed9-931d-52b857bd59e5', 'token-exchange', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('acb18db7-eaba-499c-bb1b-165fe91bd0d0', 'map-role-composite', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('ba78fd56-2ba8-4024-b58e-c6058918c402', 'impersonate', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL),
('ee8c363c-471f-4145-98d5-0451b9af09a4', 'map-role-client-scope', NULL, '343c7912-686d-4e6b-9c15-3ae53698ebfb', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE_URIS`
--

CREATE TABLE `RESOURCE_URIS` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ROLE_ATTRIBUTE`
--

CREATE TABLE `ROLE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SCOPE_MAPPING`
--

CREATE TABLE `SCOPE_MAPPING` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCOPE_MAPPING`
--

INSERT INTO `SCOPE_MAPPING` (`CLIENT_ID`, `ROLE_ID`) VALUES
('4cc70347-b41c-4f63-8428-706b68bba5d7', '1496568b-d89a-4d37-b5cc-93fbe12cf797'),
('9adfe4ca-2530-40fd-91a6-7773acca89bb', 'ef08b375-940f-42a0-a9e8-77066e60ae8b');

-- --------------------------------------------------------

--
-- Table structure for table `SCOPE_POLICY`
--

CREATE TABLE `SCOPE_POLICY` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCOPE_POLICY`
--

INSERT INTO `SCOPE_POLICY` (`SCOPE_ID`, `POLICY_ID`) VALUES
('7a299892-4fc8-4e82-b5bd-bd4d591da8a0', '2936e842-9fdf-456b-bde4-dc64fa59662f'),
('7400ca8e-d5f4-4bbf-a134-63dfc4577d43', '3f12391f-1ed5-4f49-a094-8ae2da76ad41'),
('ee8c363c-471f-4145-98d5-0451b9af09a4', '3f9f1b3b-fcba-44f1-947c-ee7ae7bce403'),
('4c14e59e-67e4-4f4d-adbb-cdc3cbf38164', '806e2cfc-9d97-487c-8287-dc610e655336'),
('29180d88-65ec-4c8c-bb0d-a2a0ad3a7068', '9a59a09b-0aa6-46ef-8aee-9387f6c1a364'),
('ba78fd56-2ba8-4024-b58e-c6058918c402', '9e43811e-a66d-4185-81d8-b4be1107242d'),
('1afc67be-93ec-449d-a99d-aecdc5324e1b', 'c8c7beca-55f3-4020-bdf6-61253154009d'),
('6b82cf11-ed83-422e-bc64-2d685f58fe1c', 'ceacac10-57b5-45e5-b704-9fb0ec87e122'),
('acb18db7-eaba-499c-bb1b-165fe91bd0d0', 'd7b904ec-9b08-4ca1-903b-c9c69e08834c');

-- --------------------------------------------------------

--
-- Table structure for table `USERNAME_LOGIN_FAILURE`
--

CREATE TABLE `USERNAME_LOGIN_FAILURE` (
  `REALM_ID` varchar(36) NOT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `FAILED_LOGIN_NOT_BEFORE` int(11) DEFAULT NULL,
  `LAST_FAILURE` bigint(20) DEFAULT NULL,
  `LAST_IP_FAILURE` varchar(255) DEFAULT NULL,
  `NUM_FAILURES` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_ATTRIBUTE`
--

CREATE TABLE `USER_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_CONSENT`
--

CREATE TABLE `USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint(20) DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_CONSENT_CLIENT_SCOPE`
--

CREATE TABLE `USER_CONSENT_CLIENT_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_ENTITY`
--

CREATE TABLE `USER_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_CONSTRAINT` varchar(255) DEFAULT NULL,
  `EMAIL_VERIFIED` bit(1) NOT NULL DEFAULT b'0',
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FEDERATION_LINK` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `LAST_NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint(20) DEFAULT NULL,
  `SERVICE_ACCOUNT_CLIENT_LINK` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER_ENTITY`
--

INSERT INTO `USER_ENTITY` (`ID`, `EMAIL`, `EMAIL_CONSTRAINT`, `EMAIL_VERIFIED`, `ENABLED`, `FEDERATION_LINK`, `FIRST_NAME`, `LAST_NAME`, `REALM_ID`, `USERNAME`, `CREATED_TIMESTAMP`, `SERVICE_ACCOUNT_CLIENT_LINK`, `NOT_BEFORE`) VALUES
('4c996821-0851-4305-94f8-b416c08a8516', 'admin1@dms-grooo.com.vn', 'admin1@dms-grooo.com.vn', b'1', b'1', NULL, 'Admin 1', '', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'admin1', 1673430330248, NULL, 0),
('6b723177-c94b-41a8-a8fd-51e928d07471', NULL, '099ef408-cc1f-44fe-bb89-14094c766eeb', b'0', b'1', NULL, NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'service-account-dms', 1669104614078, '68c51fb6-dfff-40f6-9e26-9464e60b6894', 0),
('801b5074-17de-48ad-a636-c30d530c12f6', 'admin@dms-grooo.com.vn', 'admin@dms-grooo.com.vn', b'1', b'1', NULL, 'Admin', '', 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'admin', 1673430240717, NULL, 0),
('9b34efb0-5068-4096-bdd0-fb4b56e85806', NULL, '9e0580ac-a6e5-4b6f-a3bd-188727b3845c', b'0', b'1', NULL, NULL, NULL, 'ebfc4b17-ab85-4133-98fa-d6c0fcfbcebf', 'service-account-realm-management', 1669175159582, '343c7912-686d-4e6b-9c15-3ae53698ebfb', 0),
('be5161db-84d8-47d2-a962-799878755e67', NULL, 'e0951ab7-3556-4744-97c4-1e3a5ea134d0', b'0', b'1', NULL, '', '', 'ad3a9024-ffab-4299-a385-b777720941f3', 'admin', 1673343478163, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `USER_FEDERATION_CONFIG`
--

CREATE TABLE `USER_FEDERATION_CONFIG` (
  `USER_FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_FEDERATION_MAPPER`
--

CREATE TABLE `USER_FEDERATION_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `FEDERATION_MAPPER_TYPE` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_FEDERATION_MAPPER_CONFIG`
--

CREATE TABLE `USER_FEDERATION_MAPPER_CONFIG` (
  `USER_FEDERATION_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_FEDERATION_PROVIDER`
--

CREATE TABLE `USER_FEDERATION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `CHANGED_SYNC_PERIOD` int(11) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `FULL_SYNC_PERIOD` int(11) DEFAULT NULL,
  `LAST_SYNC` int(11) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `PROVIDER_NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_GROUP_MEMBERSHIP`
--

CREATE TABLE `USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER_GROUP_MEMBERSHIP`
--

INSERT INTO `USER_GROUP_MEMBERSHIP` (`GROUP_ID`, `USER_ID`) VALUES
('80f08200-a29d-4471-85ea-490aaf5569d9', '4c996821-0851-4305-94f8-b416c08a8516'),
('80f08200-a29d-4471-85ea-490aaf5569d9', '801b5074-17de-48ad-a636-c30d530c12f6');

-- --------------------------------------------------------

--
-- Table structure for table `USER_REQUIRED_ACTION`
--

CREATE TABLE `USER_REQUIRED_ACTION` (
  `USER_ID` varchar(36) NOT NULL,
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' '
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_ROLE_MAPPING`
--

CREATE TABLE `USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(255) NOT NULL,
  `USER_ID` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER_ROLE_MAPPING`
--

INSERT INTO `USER_ROLE_MAPPING` (`ROLE_ID`, `USER_ID`) VALUES
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '4c996821-0851-4305-94f8-b416c08a8516'),
('1826d3f2-39ba-4c06-af1c-1d7f80968540', '6b723177-c94b-41a8-a8fd-51e928d07471'),
('368d453f-45fc-4d6a-a0ab-d52ee83a0313', '6b723177-c94b-41a8-a8fd-51e928d07471'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '6b723177-c94b-41a8-a8fd-51e928d07471'),
('d50ac9a8-ad04-4f99-b5cc-4dbc7d1dca75', '6b723177-c94b-41a8-a8fd-51e928d07471'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '801b5074-17de-48ad-a636-c30d530c12f6'),
('c7fee8d0-eecd-4f6b-801f-a9e02dbedf85', '9b34efb0-5068-4096-bdd0-fb4b56e85806'),
('ea9dab55-f916-4254-95c9-d1d29b1270eb', '9b34efb0-5068-4096-bdd0-fb4b56e85806'),
('0a7b5354-ce19-4902-81b8-651d2d340817', 'be5161db-84d8-47d2-a962-799878755e67'),
('9ffdde51-ca66-4a03-bb03-94d2655f81bd', 'be5161db-84d8-47d2-a962-799878755e67');

-- --------------------------------------------------------

--
-- Table structure for table `USER_SESSION`
--

CREATE TABLE `USER_SESSION` (
  `ID` varchar(36) NOT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_SESSION_REFRESH` int(11) DEFAULT NULL,
  `LOGIN_USERNAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `STARTED` int(11) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `USER_SESSION_STATE` int(11) DEFAULT NULL,
  `BROKER_SESSION_ID` varchar(255) DEFAULT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_SESSION_NOTE`
--

CREATE TABLE `USER_SESSION_NOTE` (
  `USER_SESSION` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `WEB_ORIGINS`
--

CREATE TABLE `WEB_ORIGINS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `WEB_ORIGINS`
--

INSERT INTO `WEB_ORIGINS` (`CLIENT_ID`, `VALUE`) VALUES
('4acd89d8-9537-4d58-8486-df058afeaaeb', '+'),
('77a90979-ac34-4353-9700-11005d688749', '+');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ADMIN_EVENT_ENTITY`
--
ALTER TABLE `ADMIN_EVENT_ENTITY`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_ADMIN_EVENT_TIME` (`REALM_ID`,`ADMIN_EVENT_TIME`);

--
-- Indexes for table `ASSOCIATED_POLICY`
--
ALTER TABLE `ASSOCIATED_POLICY`
  ADD PRIMARY KEY (`POLICY_ID`,`ASSOCIATED_POLICY_ID`),
  ADD KEY `IDX_ASSOC_POL_ASSOC_POL_ID` (`ASSOCIATED_POLICY_ID`);

--
-- Indexes for table `AUTHENTICATION_EXECUTION`
--
ALTER TABLE `AUTHENTICATION_EXECUTION`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_AUTH_EXEC_REALM_FLOW` (`REALM_ID`,`FLOW_ID`),
  ADD KEY `IDX_AUTH_EXEC_FLOW` (`FLOW_ID`);

--
-- Indexes for table `AUTHENTICATION_FLOW`
--
ALTER TABLE `AUTHENTICATION_FLOW`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_AUTH_FLOW_REALM` (`REALM_ID`);

--
-- Indexes for table `AUTHENTICATOR_CONFIG`
--
ALTER TABLE `AUTHENTICATOR_CONFIG`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_AUTH_CONFIG_REALM` (`REALM_ID`);

--
-- Indexes for table `AUTHENTICATOR_CONFIG_ENTRY`
--
ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY`
  ADD PRIMARY KEY (`AUTHENTICATOR_ID`,`NAME`);

--
-- Indexes for table `BROKER_LINK`
--
ALTER TABLE `BROKER_LINK`
  ADD PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`);

--
-- Indexes for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_B71CJLBENV945RB6GCON438AT` (`REALM_ID`,`CLIENT_ID`),
  ADD KEY `IDX_CLIENT_ID` (`CLIENT_ID`);

--
-- Indexes for table `CLIENT_ATTRIBUTES`
--
ALTER TABLE `CLIENT_ATTRIBUTES`
  ADD PRIMARY KEY (`CLIENT_ID`,`NAME`),
  ADD KEY `IDX_CLIENT_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`(255));

--
-- Indexes for table `CLIENT_AUTH_FLOW_BINDINGS`
--
ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS`
  ADD PRIMARY KEY (`CLIENT_ID`,`BINDING_NAME`);

--
-- Indexes for table `CLIENT_INITIAL_ACCESS`
--
ALTER TABLE `CLIENT_INITIAL_ACCESS`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_CLIENT_INIT_ACC_REALM` (`REALM_ID`);

--
-- Indexes for table `CLIENT_NODE_REGISTRATIONS`
--
ALTER TABLE `CLIENT_NODE_REGISTRATIONS`
  ADD PRIMARY KEY (`CLIENT_ID`,`NAME`);

--
-- Indexes for table `CLIENT_SCOPE`
--
ALTER TABLE `CLIENT_SCOPE`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_CLI_SCOPE` (`REALM_ID`,`NAME`),
  ADD KEY `IDX_REALM_CLSCOPE` (`REALM_ID`);

--
-- Indexes for table `CLIENT_SCOPE_ATTRIBUTES`
--
ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES`
  ADD PRIMARY KEY (`SCOPE_ID`,`NAME`),
  ADD KEY `IDX_CLSCOPE_ATTRS` (`SCOPE_ID`);

--
-- Indexes for table `CLIENT_SCOPE_CLIENT`
--
ALTER TABLE `CLIENT_SCOPE_CLIENT`
  ADD PRIMARY KEY (`CLIENT_ID`,`SCOPE_ID`),
  ADD KEY `IDX_CLSCOPE_CL` (`CLIENT_ID`),
  ADD KEY `IDX_CL_CLSCOPE` (`SCOPE_ID`);

--
-- Indexes for table `CLIENT_SCOPE_ROLE_MAPPING`
--
ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING`
  ADD PRIMARY KEY (`SCOPE_ID`,`ROLE_ID`),
  ADD KEY `IDX_CLSCOPE_ROLE` (`SCOPE_ID`),
  ADD KEY `IDX_ROLE_CLSCOPE` (`ROLE_ID`);

--
-- Indexes for table `CLIENT_SESSION`
--
ALTER TABLE `CLIENT_SESSION`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_CLIENT_SESSION_SESSION` (`SESSION_ID`);

--
-- Indexes for table `CLIENT_SESSION_AUTH_STATUS`
--
ALTER TABLE `CLIENT_SESSION_AUTH_STATUS`
  ADD PRIMARY KEY (`CLIENT_SESSION`,`AUTHENTICATOR`);

--
-- Indexes for table `CLIENT_SESSION_NOTE`
--
ALTER TABLE `CLIENT_SESSION_NOTE`
  ADD PRIMARY KEY (`CLIENT_SESSION`,`NAME`);

--
-- Indexes for table `CLIENT_SESSION_PROT_MAPPER`
--
ALTER TABLE `CLIENT_SESSION_PROT_MAPPER`
  ADD PRIMARY KEY (`CLIENT_SESSION`,`PROTOCOL_MAPPER_ID`);

--
-- Indexes for table `CLIENT_SESSION_ROLE`
--
ALTER TABLE `CLIENT_SESSION_ROLE`
  ADD PRIMARY KEY (`CLIENT_SESSION`,`ROLE_ID`);

--
-- Indexes for table `CLIENT_USER_SESSION_NOTE`
--
ALTER TABLE `CLIENT_USER_SESSION_NOTE`
  ADD PRIMARY KEY (`CLIENT_SESSION`,`NAME`);

--
-- Indexes for table `COMPONENT`
--
ALTER TABLE `COMPONENT`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_COMPONENT_REALM` (`REALM_ID`),
  ADD KEY `IDX_COMPONENT_PROVIDER_TYPE` (`PROVIDER_TYPE`);

--
-- Indexes for table `COMPONENT_CONFIG`
--
ALTER TABLE `COMPONENT_CONFIG`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_COMPO_CONFIG_COMPO` (`COMPONENT_ID`);

--
-- Indexes for table `COMPOSITE_ROLE`
--
ALTER TABLE `COMPOSITE_ROLE`
  ADD PRIMARY KEY (`COMPOSITE`,`CHILD_ROLE`),
  ADD KEY `IDX_COMPOSITE` (`COMPOSITE`),
  ADD KEY `IDX_COMPOSITE_CHILD` (`CHILD_ROLE`);

--
-- Indexes for table `CREDENTIAL`
--
ALTER TABLE `CREDENTIAL`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_USER_CREDENTIAL` (`USER_ID`);

--
-- Indexes for table `DATABASECHANGELOGLOCK`
--
ALTER TABLE `DATABASECHANGELOGLOCK`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `DEFAULT_CLIENT_SCOPE`
--
ALTER TABLE `DEFAULT_CLIENT_SCOPE`
  ADD PRIMARY KEY (`REALM_ID`,`SCOPE_ID`),
  ADD KEY `IDX_DEFCLS_REALM` (`REALM_ID`),
  ADD KEY `IDX_DEFCLS_SCOPE` (`SCOPE_ID`);

--
-- Indexes for table `EVENT_ENTITY`
--
ALTER TABLE `EVENT_ENTITY`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_EVENT_TIME` (`REALM_ID`,`EVENT_TIME`);

--
-- Indexes for table `FEDERATED_IDENTITY`
--
ALTER TABLE `FEDERATED_IDENTITY`
  ADD PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`),
  ADD KEY `IDX_FEDIDENTITY_USER` (`USER_ID`),
  ADD KEY `IDX_FEDIDENTITY_FEDUSER` (`FEDERATED_USER_ID`);

--
-- Indexes for table `FEDERATED_USER`
--
ALTER TABLE `FEDERATED_USER`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `FED_USER_ATTRIBUTE`
--
ALTER TABLE `FED_USER_ATTRIBUTE`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_FU_ATTRIBUTE` (`USER_ID`,`REALM_ID`,`NAME`);

--
-- Indexes for table `FED_USER_CONSENT`
--
ALTER TABLE `FED_USER_CONSENT`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_FU_CONSENT` (`USER_ID`,`CLIENT_ID`),
  ADD KEY `IDX_FU_CONSENT_RU` (`REALM_ID`,`USER_ID`),
  ADD KEY `IDX_FU_CNSNT_EXT` (`USER_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`);

--
-- Indexes for table `FED_USER_CONSENT_CL_SCOPE`
--
ALTER TABLE `FED_USER_CONSENT_CL_SCOPE`
  ADD PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`);

--
-- Indexes for table `FED_USER_CREDENTIAL`
--
ALTER TABLE `FED_USER_CREDENTIAL`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_FU_CREDENTIAL` (`USER_ID`,`TYPE`),
  ADD KEY `IDX_FU_CREDENTIAL_RU` (`REALM_ID`,`USER_ID`);

--
-- Indexes for table `FED_USER_GROUP_MEMBERSHIP`
--
ALTER TABLE `FED_USER_GROUP_MEMBERSHIP`
  ADD PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  ADD KEY `IDX_FU_GROUP_MEMBERSHIP` (`USER_ID`,`GROUP_ID`),
  ADD KEY `IDX_FU_GROUP_MEMBERSHIP_RU` (`REALM_ID`,`USER_ID`);

--
-- Indexes for table `FED_USER_REQUIRED_ACTION`
--
ALTER TABLE `FED_USER_REQUIRED_ACTION`
  ADD PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  ADD KEY `IDX_FU_REQUIRED_ACTION` (`USER_ID`,`REQUIRED_ACTION`),
  ADD KEY `IDX_FU_REQUIRED_ACTION_RU` (`REALM_ID`,`USER_ID`);

--
-- Indexes for table `FED_USER_ROLE_MAPPING`
--
ALTER TABLE `FED_USER_ROLE_MAPPING`
  ADD PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  ADD KEY `IDX_FU_ROLE_MAPPING` (`USER_ID`,`ROLE_ID`),
  ADD KEY `IDX_FU_ROLE_MAPPING_RU` (`REALM_ID`,`USER_ID`);

--
-- Indexes for table `GROUP_ATTRIBUTE`
--
ALTER TABLE `GROUP_ATTRIBUTE`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_GROUP_ATTR_GROUP` (`GROUP_ID`);

--
-- Indexes for table `GROUP_ROLE_MAPPING`
--
ALTER TABLE `GROUP_ROLE_MAPPING`
  ADD PRIMARY KEY (`ROLE_ID`,`GROUP_ID`),
  ADD KEY `IDX_GROUP_ROLE_MAPP_GROUP` (`GROUP_ID`);

--
-- Indexes for table `IDENTITY_PROVIDER`
--
ALTER TABLE `IDENTITY_PROVIDER`
  ADD PRIMARY KEY (`INTERNAL_ID`),
  ADD UNIQUE KEY `UK_2DAELWNIBJI49AVXSRTUF6XJ33` (`PROVIDER_ALIAS`,`REALM_ID`),
  ADD KEY `IDX_IDENT_PROV_REALM` (`REALM_ID`);

--
-- Indexes for table `IDENTITY_PROVIDER_CONFIG`
--
ALTER TABLE `IDENTITY_PROVIDER_CONFIG`
  ADD PRIMARY KEY (`IDENTITY_PROVIDER_ID`,`NAME`);

--
-- Indexes for table `IDENTITY_PROVIDER_MAPPER`
--
ALTER TABLE `IDENTITY_PROVIDER_MAPPER`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_ID_PROV_MAPP_REALM` (`REALM_ID`);

--
-- Indexes for table `IDP_MAPPER_CONFIG`
--
ALTER TABLE `IDP_MAPPER_CONFIG`
  ADD PRIMARY KEY (`IDP_MAPPER_ID`,`NAME`);

--
-- Indexes for table `KEYCLOAK_GROUP`
--
ALTER TABLE `KEYCLOAK_GROUP`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `SIBLING_NAMES` (`REALM_ID`,`PARENT_GROUP`,`NAME`);

--
-- Indexes for table `KEYCLOAK_ROLE`
--
ALTER TABLE `KEYCLOAK_ROLE`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_J3RWUVD56ONTGSUHOGM184WW2-2` (`NAME`,`CLIENT_REALM_CONSTRAINT`),
  ADD KEY `IDX_KEYCLOAK_ROLE_CLIENT` (`CLIENT`),
  ADD KEY `IDX_KEYCLOAK_ROLE_REALM` (`REALM`);

--
-- Indexes for table `MIGRATION_MODEL`
--
ALTER TABLE `MIGRATION_MODEL`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_UPDATE_TIME` (`UPDATE_TIME`);

--
-- Indexes for table `OFFLINE_CLIENT_SESSION`
--
ALTER TABLE `OFFLINE_CLIENT_SESSION`
  ADD PRIMARY KEY (`USER_SESSION_ID`,`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`OFFLINE_FLAG`),
  ADD KEY `IDX_US_SESS_ID_ON_CL_SESS` (`USER_SESSION_ID`),
  ADD KEY `IDX_OFFLINE_CSS_PRELOAD` (`CLIENT_ID`,`OFFLINE_FLAG`);

--
-- Indexes for table `OFFLINE_USER_SESSION`
--
ALTER TABLE `OFFLINE_USER_SESSION`
  ADD PRIMARY KEY (`USER_SESSION_ID`,`OFFLINE_FLAG`),
  ADD KEY `IDX_OFFLINE_USS_CREATEDON` (`CREATED_ON`),
  ADD KEY `IDX_OFFLINE_USS_PRELOAD` (`OFFLINE_FLAG`,`CREATED_ON`,`USER_SESSION_ID`),
  ADD KEY `IDX_OFFLINE_USS_BY_USER` (`USER_ID`,`REALM_ID`,`OFFLINE_FLAG`),
  ADD KEY `IDX_OFFLINE_USS_BY_USERSESS` (`REALM_ID`,`OFFLINE_FLAG`,`USER_SESSION_ID`);

--
-- Indexes for table `POLICY_CONFIG`
--
ALTER TABLE `POLICY_CONFIG`
  ADD PRIMARY KEY (`POLICY_ID`,`NAME`);

--
-- Indexes for table `PROTOCOL_MAPPER`
--
ALTER TABLE `PROTOCOL_MAPPER`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_PROTOCOL_MAPPER_CLIENT` (`CLIENT_ID`),
  ADD KEY `IDX_CLSCOPE_PROTMAP` (`CLIENT_SCOPE_ID`);

--
-- Indexes for table `PROTOCOL_MAPPER_CONFIG`
--
ALTER TABLE `PROTOCOL_MAPPER_CONFIG`
  ADD PRIMARY KEY (`PROTOCOL_MAPPER_ID`,`NAME`);

--
-- Indexes for table `REALM`
--
ALTER TABLE `REALM`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_ORVSDMLA56612EAEFIQ6WL5OI` (`NAME`),
  ADD KEY `IDX_REALM_MASTER_ADM_CLI` (`MASTER_ADMIN_CLIENT`);

--
-- Indexes for table `REALM_ATTRIBUTE`
--
ALTER TABLE `REALM_ATTRIBUTE`
  ADD PRIMARY KEY (`NAME`,`REALM_ID`),
  ADD KEY `IDX_REALM_ATTR_REALM` (`REALM_ID`);

--
-- Indexes for table `REALM_DEFAULT_GROUPS`
--
ALTER TABLE `REALM_DEFAULT_GROUPS`
  ADD PRIMARY KEY (`REALM_ID`,`GROUP_ID`),
  ADD UNIQUE KEY `CON_GROUP_ID_DEF_GROUPS` (`GROUP_ID`),
  ADD KEY `IDX_REALM_DEF_GRP_REALM` (`REALM_ID`);

--
-- Indexes for table `REALM_ENABLED_EVENT_TYPES`
--
ALTER TABLE `REALM_ENABLED_EVENT_TYPES`
  ADD PRIMARY KEY (`REALM_ID`,`VALUE`),
  ADD KEY `IDX_REALM_EVT_TYPES_REALM` (`REALM_ID`);

--
-- Indexes for table `REALM_EVENTS_LISTENERS`
--
ALTER TABLE `REALM_EVENTS_LISTENERS`
  ADD PRIMARY KEY (`REALM_ID`,`VALUE`),
  ADD KEY `IDX_REALM_EVT_LIST_REALM` (`REALM_ID`);

--
-- Indexes for table `REALM_LOCALIZATIONS`
--
ALTER TABLE `REALM_LOCALIZATIONS`
  ADD PRIMARY KEY (`REALM_ID`,`LOCALE`);

--
-- Indexes for table `REALM_REQUIRED_CREDENTIAL`
--
ALTER TABLE `REALM_REQUIRED_CREDENTIAL`
  ADD PRIMARY KEY (`REALM_ID`,`TYPE`);

--
-- Indexes for table `REALM_SMTP_CONFIG`
--
ALTER TABLE `REALM_SMTP_CONFIG`
  ADD PRIMARY KEY (`REALM_ID`,`NAME`);

--
-- Indexes for table `REALM_SUPPORTED_LOCALES`
--
ALTER TABLE `REALM_SUPPORTED_LOCALES`
  ADD PRIMARY KEY (`REALM_ID`,`VALUE`),
  ADD KEY `IDX_REALM_SUPP_LOCAL_REALM` (`REALM_ID`);

--
-- Indexes for table `REDIRECT_URIS`
--
ALTER TABLE `REDIRECT_URIS`
  ADD PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  ADD KEY `IDX_REDIR_URI_CLIENT` (`CLIENT_ID`);

--
-- Indexes for table `REQUIRED_ACTION_CONFIG`
--
ALTER TABLE `REQUIRED_ACTION_CONFIG`
  ADD PRIMARY KEY (`REQUIRED_ACTION_ID`,`NAME`);

--
-- Indexes for table `REQUIRED_ACTION_PROVIDER`
--
ALTER TABLE `REQUIRED_ACTION_PROVIDER`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_REQ_ACT_PROV_REALM` (`REALM_ID`);

--
-- Indexes for table `RESOURCE_ATTRIBUTE`
--
ALTER TABLE `RESOURCE_ATTRIBUTE`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_5HRM2VLF9QL5FU022KQEPOVBR` (`RESOURCE_ID`);

--
-- Indexes for table `RESOURCE_POLICY`
--
ALTER TABLE `RESOURCE_POLICY`
  ADD PRIMARY KEY (`RESOURCE_ID`,`POLICY_ID`),
  ADD KEY `IDX_RES_POLICY_POLICY` (`POLICY_ID`);

--
-- Indexes for table `RESOURCE_SCOPE`
--
ALTER TABLE `RESOURCE_SCOPE`
  ADD PRIMARY KEY (`RESOURCE_ID`,`SCOPE_ID`),
  ADD KEY `IDX_RES_SCOPE_SCOPE` (`SCOPE_ID`);

--
-- Indexes for table `RESOURCE_SERVER`
--
ALTER TABLE `RESOURCE_SERVER`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `RESOURCE_SERVER_PERM_TICKET`
--
ALTER TABLE `RESOURCE_SERVER_PERM_TICKET`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5PMT` (`OWNER`,`REQUESTER`,`RESOURCE_SERVER_ID`,`RESOURCE_ID`,`SCOPE_ID`),
  ADD KEY `FK_FRSRHO213XCX4WNKOG82SSPMT` (`RESOURCE_SERVER_ID`),
  ADD KEY `FK_FRSRHO213XCX4WNKOG83SSPMT` (`RESOURCE_ID`),
  ADD KEY `FK_FRSRHO213XCX4WNKOG84SSPMT` (`SCOPE_ID`),
  ADD KEY `FK_FRSRPO2128CX4WNKOG82SSRFY` (`POLICY_ID`);

--
-- Indexes for table `RESOURCE_SERVER_POLICY`
--
ALTER TABLE `RESOURCE_SERVER_POLICY`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_FRSRPT700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  ADD KEY `IDX_RES_SERV_POL_RES_SERV` (`RESOURCE_SERVER_ID`);

--
-- Indexes for table `RESOURCE_SERVER_RESOURCE`
--
ALTER TABLE `RESOURCE_SERVER_RESOURCE`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5HA6` (`NAME`,`OWNER`,`RESOURCE_SERVER_ID`),
  ADD KEY `IDX_RES_SRV_RES_RES_SRV` (`RESOURCE_SERVER_ID`);

--
-- Indexes for table `RESOURCE_SERVER_SCOPE`
--
ALTER TABLE `RESOURCE_SERVER_SCOPE`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_FRSRST700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  ADD KEY `IDX_RES_SRV_SCOPE_RES_SRV` (`RESOURCE_SERVER_ID`);

--
-- Indexes for table `RESOURCE_URIS`
--
ALTER TABLE `RESOURCE_URIS`
  ADD PRIMARY KEY (`RESOURCE_ID`,`VALUE`);

--
-- Indexes for table `ROLE_ATTRIBUTE`
--
ALTER TABLE `ROLE_ATTRIBUTE`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_ROLE_ATTRIBUTE` (`ROLE_ID`);

--
-- Indexes for table `SCOPE_MAPPING`
--
ALTER TABLE `SCOPE_MAPPING`
  ADD PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  ADD KEY `IDX_SCOPE_MAPPING_ROLE` (`ROLE_ID`);

--
-- Indexes for table `SCOPE_POLICY`
--
ALTER TABLE `SCOPE_POLICY`
  ADD PRIMARY KEY (`SCOPE_ID`,`POLICY_ID`),
  ADD KEY `IDX_SCOPE_POLICY_POLICY` (`POLICY_ID`);

--
-- Indexes for table `USERNAME_LOGIN_FAILURE`
--
ALTER TABLE `USERNAME_LOGIN_FAILURE`
  ADD PRIMARY KEY (`REALM_ID`,`USERNAME`);

--
-- Indexes for table `USER_ATTRIBUTE`
--
ALTER TABLE `USER_ATTRIBUTE`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_USER_ATTRIBUTE` (`USER_ID`),
  ADD KEY `IDX_USER_ATTRIBUTE_NAME` (`NAME`,`VALUE`);

--
-- Indexes for table `USER_CONSENT`
--
ALTER TABLE `USER_CONSENT`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_JKUWUVD56ONTGSUHOGM8UEWRT` (`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`USER_ID`),
  ADD KEY `IDX_USER_CONSENT` (`USER_ID`);

--
-- Indexes for table `USER_CONSENT_CLIENT_SCOPE`
--
ALTER TABLE `USER_CONSENT_CLIENT_SCOPE`
  ADD PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`),
  ADD KEY `IDX_USCONSENT_CLSCOPE` (`USER_CONSENT_ID`);

--
-- Indexes for table `USER_ENTITY`
--
ALTER TABLE `USER_ENTITY`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UK_DYKN684SL8UP1CRFEI6ECKHD7` (`REALM_ID`,`EMAIL_CONSTRAINT`),
  ADD UNIQUE KEY `UK_RU8TT6T700S9V50BU18WS5HA6` (`REALM_ID`,`USERNAME`),
  ADD KEY `IDX_USER_EMAIL` (`EMAIL`),
  ADD KEY `IDX_USER_SERVICE_ACCOUNT` (`REALM_ID`,`SERVICE_ACCOUNT_CLIENT_LINK`);

--
-- Indexes for table `USER_FEDERATION_CONFIG`
--
ALTER TABLE `USER_FEDERATION_CONFIG`
  ADD PRIMARY KEY (`USER_FEDERATION_PROVIDER_ID`,`NAME`);

--
-- Indexes for table `USER_FEDERATION_MAPPER`
--
ALTER TABLE `USER_FEDERATION_MAPPER`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_USR_FED_MAP_FED_PRV` (`FEDERATION_PROVIDER_ID`),
  ADD KEY `IDX_USR_FED_MAP_REALM` (`REALM_ID`);

--
-- Indexes for table `USER_FEDERATION_MAPPER_CONFIG`
--
ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG`
  ADD PRIMARY KEY (`USER_FEDERATION_MAPPER_ID`,`NAME`);

--
-- Indexes for table `USER_FEDERATION_PROVIDER`
--
ALTER TABLE `USER_FEDERATION_PROVIDER`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDX_USR_FED_PRV_REALM` (`REALM_ID`);

--
-- Indexes for table `USER_GROUP_MEMBERSHIP`
--
ALTER TABLE `USER_GROUP_MEMBERSHIP`
  ADD PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  ADD KEY `IDX_USER_GROUP_MAPPING` (`USER_ID`);

--
-- Indexes for table `USER_REQUIRED_ACTION`
--
ALTER TABLE `USER_REQUIRED_ACTION`
  ADD PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  ADD KEY `IDX_USER_REQACTIONS` (`USER_ID`);

--
-- Indexes for table `USER_ROLE_MAPPING`
--
ALTER TABLE `USER_ROLE_MAPPING`
  ADD PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  ADD KEY `IDX_USER_ROLE_MAPPING` (`USER_ID`);

--
-- Indexes for table `USER_SESSION`
--
ALTER TABLE `USER_SESSION`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `USER_SESSION_NOTE`
--
ALTER TABLE `USER_SESSION_NOTE`
  ADD PRIMARY KEY (`USER_SESSION`,`NAME`);

--
-- Indexes for table `WEB_ORIGINS`
--
ALTER TABLE `WEB_ORIGINS`
  ADD PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  ADD KEY `IDX_WEB_ORIG_CLIENT` (`CLIENT_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ASSOCIATED_POLICY`
--
ALTER TABLE `ASSOCIATED_POLICY`
  ADD CONSTRAINT `FK_FRSR5S213XCX4WNKOG82SSRFY` FOREIGN KEY (`ASSOCIATED_POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  ADD CONSTRAINT `FK_FRSRPAS14XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`);

--
-- Constraints for table `AUTHENTICATION_EXECUTION`
--
ALTER TABLE `AUTHENTICATION_EXECUTION`
  ADD CONSTRAINT `FK_AUTH_EXEC_FLOW` FOREIGN KEY (`FLOW_ID`) REFERENCES `AUTHENTICATION_FLOW` (`ID`),
  ADD CONSTRAINT `FK_AUTH_EXEC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `AUTHENTICATION_FLOW`
--
ALTER TABLE `AUTHENTICATION_FLOW`
  ADD CONSTRAINT `FK_AUTH_FLOW_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `AUTHENTICATOR_CONFIG`
--
ALTER TABLE `AUTHENTICATOR_CONFIG`
  ADD CONSTRAINT `FK_AUTH_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `CLIENT_ATTRIBUTES`
--
ALTER TABLE `CLIENT_ATTRIBUTES`
  ADD CONSTRAINT `FK3C47C64BEACCA966` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`);

--
-- Constraints for table `CLIENT_INITIAL_ACCESS`
--
ALTER TABLE `CLIENT_INITIAL_ACCESS`
  ADD CONSTRAINT `FK_CLIENT_INIT_ACC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `CLIENT_NODE_REGISTRATIONS`
--
ALTER TABLE `CLIENT_NODE_REGISTRATIONS`
  ADD CONSTRAINT `FK4129723BA992F594` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`);

--
-- Constraints for table `CLIENT_SCOPE_ATTRIBUTES`
--
ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES`
  ADD CONSTRAINT `FK_CL_SCOPE_ATTR_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`);

--
-- Constraints for table `CLIENT_SCOPE_ROLE_MAPPING`
--
ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING`
  ADD CONSTRAINT `FK_CL_SCOPE_RM_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`);

--
-- Constraints for table `CLIENT_SESSION`
--
ALTER TABLE `CLIENT_SESSION`
  ADD CONSTRAINT `FK_B4AO2VCVAT6UKAU74WBWTFQO1` FOREIGN KEY (`SESSION_ID`) REFERENCES `USER_SESSION` (`ID`);

--
-- Constraints for table `CLIENT_SESSION_AUTH_STATUS`
--
ALTER TABLE `CLIENT_SESSION_AUTH_STATUS`
  ADD CONSTRAINT `AUTH_STATUS_CONSTRAINT` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`);

--
-- Constraints for table `CLIENT_SESSION_NOTE`
--
ALTER TABLE `CLIENT_SESSION_NOTE`
  ADD CONSTRAINT `FK5EDFB00FF51C2736` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`);

--
-- Constraints for table `CLIENT_SESSION_PROT_MAPPER`
--
ALTER TABLE `CLIENT_SESSION_PROT_MAPPER`
  ADD CONSTRAINT `FK_33A8SGQW18I532811V7O2DK89` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`);

--
-- Constraints for table `CLIENT_SESSION_ROLE`
--
ALTER TABLE `CLIENT_SESSION_ROLE`
  ADD CONSTRAINT `FK_11B7SGQW18I532811V7O2DV76` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`);

--
-- Constraints for table `CLIENT_USER_SESSION_NOTE`
--
ALTER TABLE `CLIENT_USER_SESSION_NOTE`
  ADD CONSTRAINT `FK_CL_USR_SES_NOTE` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`);

--
-- Constraints for table `COMPONENT`
--
ALTER TABLE `COMPONENT`
  ADD CONSTRAINT `FK_COMPONENT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `COMPONENT_CONFIG`
--
ALTER TABLE `COMPONENT_CONFIG`
  ADD CONSTRAINT `FK_COMPONENT_CONFIG` FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`);

--
-- Constraints for table `COMPOSITE_ROLE`
--
ALTER TABLE `COMPOSITE_ROLE`
  ADD CONSTRAINT `FK_A63WVEKFTU8JO1PNJ81E7MCE2` FOREIGN KEY (`COMPOSITE`) REFERENCES `KEYCLOAK_ROLE` (`ID`),
  ADD CONSTRAINT `FK_GR7THLLB9LU8Q4VQA4524JJY8` FOREIGN KEY (`CHILD_ROLE`) REFERENCES `KEYCLOAK_ROLE` (`ID`);

--
-- Constraints for table `CREDENTIAL`
--
ALTER TABLE `CREDENTIAL`
  ADD CONSTRAINT `FK_PFYR0GLASQYL0DEI3KL69R6V0` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `DEFAULT_CLIENT_SCOPE`
--
ALTER TABLE `DEFAULT_CLIENT_SCOPE`
  ADD CONSTRAINT `FK_R_DEF_CLI_SCOPE_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `FEDERATED_IDENTITY`
--
ALTER TABLE `FEDERATED_IDENTITY`
  ADD CONSTRAINT `FK404288B92EF007A6` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `GROUP_ATTRIBUTE`
--
ALTER TABLE `GROUP_ATTRIBUTE`
  ADD CONSTRAINT `FK_GROUP_ATTRIBUTE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`);

--
-- Constraints for table `GROUP_ROLE_MAPPING`
--
ALTER TABLE `GROUP_ROLE_MAPPING`
  ADD CONSTRAINT `FK_GROUP_ROLE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`);

--
-- Constraints for table `IDENTITY_PROVIDER`
--
ALTER TABLE `IDENTITY_PROVIDER`
  ADD CONSTRAINT `FK2B4EBC52AE5C3B34` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `IDENTITY_PROVIDER_CONFIG`
--
ALTER TABLE `IDENTITY_PROVIDER_CONFIG`
  ADD CONSTRAINT `FKDC4897CF864C4E43` FOREIGN KEY (`IDENTITY_PROVIDER_ID`) REFERENCES `IDENTITY_PROVIDER` (`INTERNAL_ID`);

--
-- Constraints for table `IDENTITY_PROVIDER_MAPPER`
--
ALTER TABLE `IDENTITY_PROVIDER_MAPPER`
  ADD CONSTRAINT `FK_IDPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `IDP_MAPPER_CONFIG`
--
ALTER TABLE `IDP_MAPPER_CONFIG`
  ADD CONSTRAINT `FK_IDPMCONFIG` FOREIGN KEY (`IDP_MAPPER_ID`) REFERENCES `IDENTITY_PROVIDER_MAPPER` (`ID`);

--
-- Constraints for table `KEYCLOAK_ROLE`
--
ALTER TABLE `KEYCLOAK_ROLE`
  ADD CONSTRAINT `FK_6VYQFE4CN4WLQ8R6KT5VDSJ5C` FOREIGN KEY (`REALM`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `POLICY_CONFIG`
--
ALTER TABLE `POLICY_CONFIG`
  ADD CONSTRAINT `FKDC34197CF864C4E43` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`);

--
-- Constraints for table `PROTOCOL_MAPPER`
--
ALTER TABLE `PROTOCOL_MAPPER`
  ADD CONSTRAINT `FK_CLI_SCOPE_MAPPER` FOREIGN KEY (`CLIENT_SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`),
  ADD CONSTRAINT `FK_PCM_REALM` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`);

--
-- Constraints for table `PROTOCOL_MAPPER_CONFIG`
--
ALTER TABLE `PROTOCOL_MAPPER_CONFIG`
  ADD CONSTRAINT `FK_PMCONFIG` FOREIGN KEY (`PROTOCOL_MAPPER_ID`) REFERENCES `PROTOCOL_MAPPER` (`ID`);

--
-- Constraints for table `REALM_ATTRIBUTE`
--
ALTER TABLE `REALM_ATTRIBUTE`
  ADD CONSTRAINT `FK_8SHXD6L3E9ATQUKACXGPFFPTW` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REALM_DEFAULT_GROUPS`
--
ALTER TABLE `REALM_DEFAULT_GROUPS`
  ADD CONSTRAINT `FK_DEF_GROUPS_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REALM_ENABLED_EVENT_TYPES`
--
ALTER TABLE `REALM_ENABLED_EVENT_TYPES`
  ADD CONSTRAINT `FK_H846O4H0W8EPX5NWEDRF5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REALM_EVENTS_LISTENERS`
--
ALTER TABLE `REALM_EVENTS_LISTENERS`
  ADD CONSTRAINT `FK_H846O4H0W8EPX5NXEV9F5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REALM_REQUIRED_CREDENTIAL`
--
ALTER TABLE `REALM_REQUIRED_CREDENTIAL`
  ADD CONSTRAINT `FK_5HG65LYBEVAVKQFKI3KPONH9V` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REALM_SMTP_CONFIG`
--
ALTER TABLE `REALM_SMTP_CONFIG`
  ADD CONSTRAINT `FK_70EJ8XDXGXD0B9HH6180IRR0O` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REALM_SUPPORTED_LOCALES`
--
ALTER TABLE `REALM_SUPPORTED_LOCALES`
  ADD CONSTRAINT `FK_SUPPORTED_LOCALES_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `REDIRECT_URIS`
--
ALTER TABLE `REDIRECT_URIS`
  ADD CONSTRAINT `FK_1BURS8PB4OUJ97H5WUPPAHV9F` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`);

--
-- Constraints for table `REQUIRED_ACTION_PROVIDER`
--
ALTER TABLE `REQUIRED_ACTION_PROVIDER`
  ADD CONSTRAINT `FK_REQ_ACT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `RESOURCE_ATTRIBUTE`
--
ALTER TABLE `RESOURCE_ATTRIBUTE`
  ADD CONSTRAINT `FK_5HRM2VLF9QL5FU022KQEPOVBR` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`);

--
-- Constraints for table `RESOURCE_POLICY`
--
ALTER TABLE `RESOURCE_POLICY`
  ADD CONSTRAINT `FK_FRSRPOS53XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  ADD CONSTRAINT `FK_FRSRPP213XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`);

--
-- Constraints for table `RESOURCE_SCOPE`
--
ALTER TABLE `RESOURCE_SCOPE`
  ADD CONSTRAINT `FK_FRSRPOS13XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  ADD CONSTRAINT `FK_FRSRPS213XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`);

--
-- Constraints for table `RESOURCE_SERVER_PERM_TICKET`
--
ALTER TABLE `RESOURCE_SERVER_PERM_TICKET`
  ADD CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSPMT` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`),
  ADD CONSTRAINT `FK_FRSRHO213XCX4WNKOG83SSPMT` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  ADD CONSTRAINT `FK_FRSRHO213XCX4WNKOG84SSPMT` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`),
  ADD CONSTRAINT `FK_FRSRPO2128CX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`);

--
-- Constraints for table `RESOURCE_SERVER_POLICY`
--
ALTER TABLE `RESOURCE_SERVER_POLICY`
  ADD CONSTRAINT `FK_FRSRPO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`);

--
-- Constraints for table `RESOURCE_SERVER_RESOURCE`
--
ALTER TABLE `RESOURCE_SERVER_RESOURCE`
  ADD CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`);

--
-- Constraints for table `RESOURCE_SERVER_SCOPE`
--
ALTER TABLE `RESOURCE_SERVER_SCOPE`
  ADD CONSTRAINT `FK_FRSRSO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`);

--
-- Constraints for table `RESOURCE_URIS`
--
ALTER TABLE `RESOURCE_URIS`
  ADD CONSTRAINT `FK_RESOURCE_SERVER_URIS` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`);

--
-- Constraints for table `ROLE_ATTRIBUTE`
--
ALTER TABLE `ROLE_ATTRIBUTE`
  ADD CONSTRAINT `FK_ROLE_ATTRIBUTE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `KEYCLOAK_ROLE` (`ID`);

--
-- Constraints for table `SCOPE_MAPPING`
--
ALTER TABLE `SCOPE_MAPPING`
  ADD CONSTRAINT `FK_OUSE064PLMLR732LXJCN1Q5F1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`);

--
-- Constraints for table `SCOPE_POLICY`
--
ALTER TABLE `SCOPE_POLICY`
  ADD CONSTRAINT `FK_FRSRASP13XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  ADD CONSTRAINT `FK_FRSRPASS3XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`);

--
-- Constraints for table `USER_ATTRIBUTE`
--
ALTER TABLE `USER_ATTRIBUTE`
  ADD CONSTRAINT `FK_5HRM2VLF9QL5FU043KQEPOVBR` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `USER_CONSENT`
--
ALTER TABLE `USER_CONSENT`
  ADD CONSTRAINT `FK_GRNTCSNT_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `USER_CONSENT_CLIENT_SCOPE`
--
ALTER TABLE `USER_CONSENT_CLIENT_SCOPE`
  ADD CONSTRAINT `FK_GRNTCSNT_CLSC_USC` FOREIGN KEY (`USER_CONSENT_ID`) REFERENCES `USER_CONSENT` (`ID`);

--
-- Constraints for table `USER_FEDERATION_CONFIG`
--
ALTER TABLE `USER_FEDERATION_CONFIG`
  ADD CONSTRAINT `FK_T13HPU1J94R2EBPEKR39X5EU5` FOREIGN KEY (`USER_FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`);

--
-- Constraints for table `USER_FEDERATION_MAPPER`
--
ALTER TABLE `USER_FEDERATION_MAPPER`
  ADD CONSTRAINT `FK_FEDMAPPERPM_FEDPRV` FOREIGN KEY (`FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`),
  ADD CONSTRAINT `FK_FEDMAPPERPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `USER_FEDERATION_MAPPER_CONFIG`
--
ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG`
  ADD CONSTRAINT `FK_FEDMAPPER_CFG` FOREIGN KEY (`USER_FEDERATION_MAPPER_ID`) REFERENCES `USER_FEDERATION_MAPPER` (`ID`);

--
-- Constraints for table `USER_FEDERATION_PROVIDER`
--
ALTER TABLE `USER_FEDERATION_PROVIDER`
  ADD CONSTRAINT `FK_1FJ32F6PTOLW2QY60CD8N01E8` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`);

--
-- Constraints for table `USER_GROUP_MEMBERSHIP`
--
ALTER TABLE `USER_GROUP_MEMBERSHIP`
  ADD CONSTRAINT `FK_USER_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `USER_REQUIRED_ACTION`
--
ALTER TABLE `USER_REQUIRED_ACTION`
  ADD CONSTRAINT `FK_6QJ3W1JW9CVAFHE19BWSIUVMD` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `USER_ROLE_MAPPING`
--
ALTER TABLE `USER_ROLE_MAPPING`
  ADD CONSTRAINT `FK_C4FQV34P1MBYLLOXANG7B1Q3L` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`);

--
-- Constraints for table `USER_SESSION_NOTE`
--
ALTER TABLE `USER_SESSION_NOTE`
  ADD CONSTRAINT `FK5EDFB00FF51D3472` FOREIGN KEY (`USER_SESSION`) REFERENCES `USER_SESSION` (`ID`);

--
-- Constraints for table `WEB_ORIGINS`
--
ALTER TABLE `WEB_ORIGINS`
  ADD CONSTRAINT `FK_LOJPHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
