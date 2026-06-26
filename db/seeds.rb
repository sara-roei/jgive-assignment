campaign = Campaign.find_or_create_by!(title: "הגן הכתום") do |c|
  c.description = <<~HTML
    <h2>הצטרפו עכשיו והיו ממקימי ׳הגן הכתום׳</h2>
    <h3>לזכר שירי, אריאל וכפיר ביבס, ולזכר כל ילדי ה-7 באוקטובר.</h3>
    <p>
      אחרי שנתיים וחצי של כאב, טלטלה והתמודדות,
      מגיע מיזם שמביא בשורה חדשה לישראל -
      מקום של חיים, ריפוי ותקווה.
    </p>
    <p>
      אנחנו יוצאים לדרך עם הקמת <strong>הגן הכתום</strong> -
      מרחב ראשון מסוגו בישראל שמחבר זיכרון, טבע ילדים וריפוי.
      על פני <strong>20 דונם</strong> יוקם מרחב חי של טבע, מים, משחק, משפחה וריפוי - פתוח לכולם.
    </p>
    <p>
      מקום שבו ילדים ירוצו וישחקו,
      משפחות יתכנסו יחד,
      ואנשים יוכלו לעצור לרגע, לנשום ולהתחבר מחדש.
    </p>
    <p>
      מקום שיכלול גם מרחב מכבד לזכר כל ילדי השבעה באוקטובר -
      כדי לזכור דרך החיים, האור והאהבה.
    </p>
  HTML
  c.cover_image_url = "campaign_cover.jpg"
  c.goal_amount = 5_000_000
end

donations_data = [
  { amount: 360, donor_name: "דנה כהן", display_preference: "full_name", recurring: false },
  { amount: 180, donor_name: "יוסי לוי", display_preference: "first_name", recurring: true },
  { amount: 1800, donor_name: "משפחת אברהמי", display_preference: "full_name", recurring: false },
  { amount: 260, donor_name: "רונית שמעוני", display_preference: "anonymous", recurring: false },
  { amount: 5000, donor_name: "אבי ומירב גולן", display_preference: "full_name", recurring: false },
  { amount: 360, donor_name: "תמר ברק", display_preference: "first_name", recurring: true },
  { amount: 180, donor_name: "עמית רוזנברג", display_preference: "full_name", recurring: false }
]

donations_data.each do |data|
  campaign.donations.find_or_create_by!(donor_name: data[:donor_name]) do |d|
    d.amount = data[:amount]
    d.display_preference = data[:display_preference]
    d.recurring = data[:recurring]
  end
end
