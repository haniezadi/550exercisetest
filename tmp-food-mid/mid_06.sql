DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
  -- Base food: شیر کم‌چرب (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر کم‌چرب', 'compound', 'snack', 'simple', 'snack:2:شیر-کمچرب', 'شیر کم‌چرب با حدود ۴۶ کالری / ۳٫۴ گرم پروتئین در ۱۰۰ میلی‌لیتر؛ بدون شکر، عسل و پودرهای شیرین. درصد چربی و اطلاعات روی بستهٔ شیر، مبنای دقیق‌تر محاسبه هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 110 کالری', 'compound', 'snack', 'simple',
    v_base_id, '110 کالری', 110, 8,
    'snack:2:شیر-کمچرب:110', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 12,
    'snack:2:شیر-کمچرب:160', '[{"name":"شیر کم‌چرب","amount":"۳۴۵ میلی‌لیتر","household":"۱½ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 16,
    'snack:2:شیر-کمچرب:210', '[{"name":"شیر کم‌چرب","amount":"۴۶۰ میلی‌لیتر","household":"۲ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست ساده کم‌چرب (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست ساده کم‌چرب', 'compound', 'snack', 'simple', 'snack:3:ماست-ساده-کمچرب', 'ماست معمولیِ بدون شکر افزوده با حدود ۶۰ کالری / ۴ گرم پروتئین در ۱۰۰ گرم. ماست چکیده، پرچرب یا میوه‌ای، جایگزین مستقیم این محاسبه نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 7,
    'snack:3:ماست-ساده-کمچرب:100', '[{"name":"ماست کم‌چرب","amount":"۱۶۵ گرم","household":"۱۱ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 10,
    'snack:3:ماست-ساده-کمچرب:150', '[{"name":"ماست کم‌چرب","amount":"۲۵۰ گرم","household":"حدود ۱ کاسهٔ کوچک پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 13,
    'snack:3:ماست-ساده-کمچرب:200', '[{"name":"ماست کم‌چرب","amount":"۳۳۰ گرم","household":"۲۲ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: تخم‌مرغ آب‌پز (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('تخم‌مرغ آب‌پز', 'compound', 'snack', 'simple', 'snack:4:تخممرغ-آبپز', 'هر تخم‌مرغ حدود ۵۰ گرم قسمت خوراکی، ۷۰ کالری و ۶ گرم پروتئین؛ بدون روغن. وزن‌ها بدون پوسته هستند. اندازهٔ تخم‌مرغ می‌تواند کالری و پروتئین را کمی تغییر دهد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 70 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 70 کالری', 'compound', 'snack', 'simple',
    v_base_id, '70 کالری', 70, 6,
    'snack:4:تخممرغ-آبپز:70', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 140 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 140 کالری', 'compound', 'snack', 'simple',
    v_base_id, '140 کالری', 140, 13,
    'snack:4:تخممرغ-آبپز:140', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 220 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 220 کالری', 'compound', 'snack', 'simple',
    v_base_id, '220 کالری', 220, 19,
    'snack:4:تخممرغ-آبپز:220', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۵۰ گرم","household":"۳ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خرما (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خرما', 'compound', 'snack', 'simple', 'snack:5:خرما', 'خرمای کوچک تا متوسط، بدون هسته؛ هر عدد حدود ۸ گرم. برآورد انرژی حدود ۲۸۰ کالری در ۱۰۰ گرم است. خرمای درشت، مانند مجول، با همین تعداد کالری بسیار بیشتری دارد؛ وزن بدون هسته ملاک است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 90 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 90 کالری', 'compound', 'snack', 'simple',
    v_base_id, '90 کالری', 90, 1,
    'snack:5:خرما:90', '[{"name":"خرمای بدون هسته","amount":"۳۲ گرم","household":"۴ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 130 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 130 کالری', 'compound', 'snack', 'simple',
    v_base_id, '130 کالری', 130, 1,
    'snack:5:خرما:130', '[{"name":"خرمای بدون هسته","amount":"۴۸ گرم","household":"۶ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 180 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 180 کالری', 'compound', 'snack', 'simple',
    v_base_id, '180 کالری', 180, 2,
    'snack:5:خرما:180', '[{"name":"خرمای بدون هسته","amount":"۶۴ گرم","household":"۸ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: مغز گردو (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('مغز گردو', 'compound', 'snack', 'simple', 'snack:6:مغز-گردو', 'هر مغز کامل گردوی متوسط حدود ۴ گرم است؛ یعنی دو نیمهٔ مغز گردو. وزن‌ها مربوط به مغز بدون پوست سخت هستند. اندازهٔ گردوها متفاوت است؛ تعداد فقط معادل تقریبی وزن است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:6:مغز-گردو:100', '[{"name":"مغز گردو","amount":"۱۶ گرم","household":"۴ مغز کامل گردو یا ۸ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 4,
    'snack:6:مغز-گردو:160', '[{"name":"مغز گردو","amount":"۲۴ گرم","household":"۶ مغز کامل گردو یا ۱۲ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 5,
    'snack:6:مغز-گردو:210', '[{"name":"مغز گردو","amount":"۳۲ گرم","household":"۸ مغز کامل گردو یا ۱۶ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بادام (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بادام', 'compound', 'snack', 'simple', 'snack:7:بادام', 'بادام خام یا بودادهٔ بدون روغن، بدون روکش؛ هر مغز کامل متوسط حدود ۱٫۲ گرم. بادام روغنی، شکری یا شکلاتی، با این برآورد یکسان نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 4,
    'snack:7:بادام:100', '[{"name":"بادام","amount":"۱۷ گرم","household":"۱۴ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 5,
    'snack:7:بادام:150', '[{"name":"بادام","amount":"۲۶ گرم","household":"۲۲ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 7,
    'snack:7:بادام:200', '[{"name":"بادام","amount":"۳۵ گرم","household":"۲۹ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خیار', 'compound', 'snack', 'simple', 'snack:8:خیار', 'خیار تازه، بدون سس و روغن؛ حدود ۱۵ کالری در ۱۰۰ گرم. برای خیار، سهم‌های معمول نوشته شده‌اند و مقدار آن برای رسیدن اجباری به ۲۰۰ کالری افزایش داده نشده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 20 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 20 کالری', 'compound', 'snack', 'simple',
    v_base_id, '20 کالری', 20, 1,
    'snack:8:خیار:20', '[{"name":"خیار","amount":"۱۵۰ گرم","household":"۲ عدد کوچک یا حدود ۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 30 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 30 کالری', 'compound', 'snack', 'simple',
    v_base_id, '30 کالری', 30, 1,
    'snack:8:خیار:30', '[{"name":"خیار","amount":"۲۰۰ گرم","household":"۲ عدد متوسط یا حدود ۱½ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 40 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 40 کالری', 'compound', 'snack', 'simple',
    v_base_id, '40 کالری', 40, 2,
    'snack:8:خیار:40', '[{"name":"خیار","amount":"۲۵۰ گرم","household":"۳ عدد کوچک تا متوسط یا حدود ۲ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, NULL,
    'snack:8:خیار:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: هویج (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('هویج', 'compound', 'snack', 'simple', 'snack:9:هویج', 'هویج خام، بدون سس و روغن؛ حدود ۴۱ کالری در ۱۰۰ گرم.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 40 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 40 کالری', 'compound', 'snack', 'simple',
    v_base_id, '40 کالری', 40, 1,
    'snack:9:هویج:40', '[{"name":"هویج","amount":"۱۰۰ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 60 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 60 کالری', 'compound', 'snack', 'simple',
    v_base_id, '60 کالری', 60, 1,
    'snack:9:هویج:60', '[{"name":"هویج","amount":"۱۵۰ گرم","household":"۲ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 80 کالری', 'compound', 'snack', 'simple',
    v_base_id, '80 کالری', 80, 2,
    'snack:9:هویج:80', '[{"name":"هویج","amount":"۲۰۰ گرم","household":"۲ عدد بزرگ یا ۳ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, NULL,
    'snack:9:هویج:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پاپ‌کورن بدون روغن (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پاپ‌کورن بدون روغن', 'compound', 'snack', 'simple', 'snack:10:پاپکورن-بدون-روغن', 'ذرت بوداده با هوای گرم یا در ظرف مناسب، بدون روغن، کره، شکر و کارامل. هر لیوان استاندارد پاپ‌کورنِ بدون فشردن حدود ۸ گرم است. وزن‌ها مربوط به پاپ‌کورن آماده هستند، نه دانهٔ خشک ذرت.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 3,
    'snack:10:پاپکورن-بدون-روغن:100', '[{"name":"پاپ‌کورن آماده","amount":"۲۵ گرم","household":"حدود ۳ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 5,
    'snack:10:پاپکورن-بدون-روغن:150', '[{"name":"پاپ‌کورن آماده","amount":"۴۰ گرم","household":"حدود ۵ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 7,
    'snack:10:پاپکورن-بدون-روغن:200', '[{"name":"پاپ‌کورن آماده","amount":"۵۲ گرم","household":"حدود ۶½ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: قهوه با شیر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قهوه با شیر', 'compound', 'snack', 'simple', 'snack:11:قهوه-با-شیر', 'قهوهٔ ساده همراه شیر کم‌چرب؛ بدون شکر، خامه، سیروپ و پودر کافی‌میکس. حجم شیر پیش از کف‌دادن اندازه‌گیری می‌شود. تعداد شات در هر سه نسخه ثابت است؛ افزودنی‌های شیرین جدا محاسبه می‌شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 110 کالری', 'compound', 'snack', 'simple',
    v_base_id, '110 کالری', 110, 8,
    'snack:11:قهوه-با-شیر:110', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 12,
    'snack:11:قهوه-با-شیر:160', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۳۴۵ میلی‌لیتر","household":"۱½ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 16,
    'snack:11:قهوه-با-شیر:210', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۴۶۰ میلی‌لیتر","household":"۲ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
