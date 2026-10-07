<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>सरकारी योजना सहायता</title>

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: Arial, "Noto Sans Devanagari", sans-serif;
    }

    body {
      background: #f4f7fb;
      color: #222;
    }

    header {
      background: linear-gradient(135deg, #ff7a00, #ff9800);
      color: white;
      padding: 25px 15px;
      text-align: center;
    }

    header h1 {
      font-size: 28px;
      margin-bottom: 8px;
    }

    header p {
      font-size: 15px;
    }

    .container {
      max-width: 900px;
      margin: 25px auto;
      padding: 0 15px;
    }

    .search-box {
      background: white;
      padding: 20px;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0,0,0,.08);
      margin-bottom: 20px;
    }

    input {
      width: 100%;
      padding: 14px;
      border: 1px solid #ddd;
      border-radius: 10px;
      font-size: 16px;
      outline: none;
    }

    button {
      width: 100%;
      margin-top: 12px;
      padding: 14px;
      border: none;
      border-radius: 10px;
      background: #138808;
      color: white;
      font-size: 16px;
      cursor: pointer;
    }

    button:hover {
      background: #0b7005;
    }

    .schemes {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 15px;
    }

    .card {
      background: white;
      padding: 18px;
      border-radius: 14px;
      box-shadow: 0 3px 12px rgba(0,0,0,.07);
    }

    .card h3 {
      color: #ff6b00;
      margin-bottom: 8px;
    }

    .card p {
      line-height: 1.6;
      font-size: 14px;
    }

    .ai-box {
      margin-top: 20px;
      background: white;
      padding: 20px;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0,0,0,.08);
    }

    #answer {
      margin-top: 15px;
      line-height: 1.7;
      white-space: pre-wrap;
    }

    footer {
      text-align: center;
      padding: 25px;
      margin-top: 30px;
      background: #222;
      color: white;
      font-size: 13px;
    }

    .api-note {
      margin-top: 10px;
      font-size: 12px;
      color: #777;
    }
  </style>
</head>

<body>

<header>
  <h1>🇮🇳 सरकारी योजना सहायता</h1>
  <p>भारत सरकार की योजनाओं की जानकारी हिंदी में</p>
</header>

<div class="container">

  <!-- SEARCH -->
  <div class="search-box">
    <input
      type="text"
      id="search"
      placeholder="योजना खोजें... जैसे किसान, छात्र, महिला"
      onkeyup="searchSchemes()"
    >
  </div>

  <!-- SCHEMES -->
  <div class="schemes" id="schemeList">

    <div class="card">
      <h3>प्रधानमंत्री किसान सम्मान निधि</h3>
      <p>
        पात्र किसानों को आर्थिक सहायता प्रदान करने वाली केंद्र सरकार की योजना।
      </p>
    </div>

    <div class="card">
      <h3>प्रधानमंत्री उज्ज्वला योजना</h3>
      <p>
        पात्र परिवारों को LPG कनेक्शन उपलब्ध कराने की योजना।
      </p>
    </div>

    <div class="card">
      <h3>प्रधानमंत्री आवास योजना</h3>
      <p>
        पात्र नागरिकों को पक्का घर बनाने या प्राप्त करने में सहायता।
      </p>
    </div>

    <div class="card">
      <h3>बेटी बचाओ बेटी पढ़ाओ</h3>
      <p>
        बालिकाओं की सुरक्षा, शिक्षा और सशक्तिकरण को बढ़ावा देने की पहल।
      </p>
    </div>

    <div class="card">
      <h3>प्रधानमंत्री मुद्रा योजना</h3>
      <p>
        छोटे व्यवसाय और उद्यम शुरू करने के लिए ऋण सुविधा से संबंधित योजना।
      </p>
    </div>

    <div class="card">
      <h3>आयुष्मान भारत</h3>
      <p>
        पात्र लाभार्थियों को स्वास्थ्य सेवाओं में सहायता देने वाली योजना।
      </p>
    </div>

  </div>

  <!-- AI -->
  <div class="ai-box">

    <h2>🤖 AI से योजना की जानकारी पूछें</h2>

    <input
      type="text"
      id="question"
      placeholder="उदाहरण: किसानों के लिए कौन सी सरकारी योजनाएं हैं?"
    >

    <button onclick="askAI()">
      जानकारी प्राप्त करें
    </button>

    <div id="answer"></div>

    <div class="api-note">
      ⚠️ अपनी Groq API Key नीचे JavaScript में डालें।
    </div>

  </div>

</div>

<footer>
  © 2026 सरकारी योजना सहायता | जानकारी के लिए आधिकारिक स्रोत देखें
</footer>


<script>

  // =====================================================
  // 🔑 GROQ API KEY
  // =====================================================
  // अपनी API Key यहां डालें:
  //
  // const GROQ_API_KEY = "gsk_xxxxxxxxxxxxxxxxx";
  //
  // =====================================================

  const GROQ_API_KEY = "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";


  // =====================================================
  // 🔎 SCHEME SEARCH
  // =====================================================

  function searchSchemes() {

    const text =
      document.getElementById("search").value.toLowerCase();

    const cards =
      document.querySelectorAll(".card");

    cards.forEach(card => {

      const content =
        card.innerText.toLowerCase();

      if (content.includes(text)) {
        card.style.display = "block";
      } else {
        card.style.display = "none";
      }

    });
  }


  // =====================================================
  // 🤖 GROQ AI
  // =====================================================

  async function askAI() {

    const question =
      document.getElementById("question").value.trim();

    const answer =
      document.getElementById("answer");

    if (!question) {
      answer.innerText =
        "कृपया अपना सवाल लिखें।";
      return;
    }

    if (GROQ_API_KEY === "YOUR_GROQ_API_KEY_HERE") {
      answer.innerText =
        "पहले अपनी Groq API Key JavaScript में डालें।";
      return;
    }

    answer.innerText =
      "⏳ जानकारी खोजी जा रही है...";

    try {

      const response = await fetch(
        "https://api.groq.com/openai/v1/chat/completions",
        {
          method: "POST",

          headers: {
            "Content-Type": "application/json",
            "Authorization":
              "Bearer " + GROQ_API_KEY
          },

          body: JSON.stringify({

            // वर्तमान Groq production model
            model: "openai/gpt-oss-120b",

            messages: [

              {
                role: "system",

                content:
                `आप भारत सरकार की योजनाओं के सहायक हैं।

                हमेशा हिंदी भाषा में उत्तर दें।

                योजना का नाम, पात्रता,
                लाभ, आवश्यक दस्तावेज और
                आवेदन करने का तरीका सरल भाषा में बताएं।

                गलत या काल्पनिक सरकारी योजना
                की जानकारी न बनाएं।

                जहां संभव हो नागरिक को
                आधिकारिक सरकारी वेबसाइट
                पर जानकारी सत्यापित करने की सलाह दें।`
              },

              {
                role: "user",
                content: question
              }

            ],

            temperature: 0.2,
            max_tokens: 1200

          })
        }
      );

      const data = await response.json();

      if (!response.ok) {
        throw new Error(
          data.error?.message ||
          "Groq API में समस्या हुई।"
        );
      }

      answer.innerText =
        data.choices[0].message.content;

    } catch (error) {

      answer.innerText =
        "❌ Error: " + error.message;

    }

  }

</script>

</body>
</html>
