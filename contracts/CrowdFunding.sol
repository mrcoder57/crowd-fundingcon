pragma solidity ^0.8.24;

contract CrowdFunding{
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;

    }
    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberofCampaigns;

    function createCampaign( address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256) {
        Campaign storage campaign =campaigns[numberofCampaigns];

        //is everthing good

        require(campaign.deadline < block.timestamp, "the dealine must be in future");

        campaign.owner= _owner;

        campaign.title= _title;
        campaign.description= _description;
        campaign.target= _target;
        campaign.deadline= _deadline;
        campaign.image= _image;
        campaign.amountCollected=0;


    numberofCampaigns++;

    return numberofCampaigns-1;
    }
 
    function donateToCampaign(uint256 _id) public payable {

        uint256 amount=msg.value;
        Campaign storage campaign = campaigns[_id];

        campaign.donators(msg.sender);
        campaign.donations(amount);

         (bool sent,) = payable(campaign.owner).call{value:amount}("");

         if(sent){
            campaign.amountCollected=campaign.amountCollected + amount;
         }
    }

    function getDonators(){}

    function getCampaigns(){

    }

}