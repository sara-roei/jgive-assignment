Campaign.destroy_all

campaign = Campaign.create!(
  title: "הגן הכתום",
  description: <<~HTML,
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
  cover_image_url: "campaign_cover.jpg",
  goal_amount: 5_000_000
)

[
  { amount: 360_000, donor_name: "דנה כהן", display_preference: "show_name_and_amount", recurring: false },
  { amount: 180_000, donor_name: "יוסי לוי", display_preference: "show_name_only", recurring: true },
  { amount: 250_000, donor_name: "משפחת אברהמי", display_preference: "show_name_and_amount", recurring: false },
  { amount: 50_000, donor_name: "רונית שמעוני", display_preference: "show_amount_only", recurring: false },
  { amount: 100_000, donor_name: "אבי ומירב גולן", display_preference: "show_name_and_amount", recurring: false },
  { amount: 90_000, donor_name: "תמר ברק", display_preference: "show_name_only", recurring: true },
  { amount: 49_491, donor_name: "עמית רוזנברג", display_preference: "show_name_and_amount", recurring: false }
].each do |data|
  campaign.donations.create!(data)
end
