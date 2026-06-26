class CampaignsController < ApplicationController
  def show
    @campaign = Campaign.find(params[:id])
    @donation = @campaign.donations.new
  end
end
