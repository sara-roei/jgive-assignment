class DonationsController < ApplicationController
  def create
    @campaign = Campaign.find(params[:campaign_id])
    @donation = @campaign.donations.new(donation_params)

    if @donation.save
      redirect_to campaign_path(@campaign), notice: "תודה על תרומתך!"
    else
      render "campaigns/show", status: :unprocessable_entity
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :donor_name, :display_preference, :recurring, :dedication)
  end
end
