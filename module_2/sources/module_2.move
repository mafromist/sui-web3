module module_2::hero;

use std::string::String;

public struct Hero has key, store {
    // ID field olan ve bir struct i object yaptigini soylebiliriz
    //store baska bir struct icinde konuldugunda o struct in object olmasini saglar
    // key ile copy ability leri ayni anda kullanilamaz cunku key UID gerektirir, ve kopyalanamaz
    // key ile drop ability leri ayni anda kullanilamaz cunku key drop edilemez
    // TODO: Add the fields for the Hero
    // 1. The id of the Hero
    id: UID,
    // 2. The name of the Hero
    name: String,
    // 3. The imageurl of the Hero
    image_url: String,
    // 4. The power of the Hero
    //u8 daha mantikli bir secim olurdu cunku daha az yer kaplardi ama orneginin aynisi olsun diye u64 kullandim
    power: u64,
}

#[allow(lint(self_transfer))]
public entry fun create_hero(name: String, image_url: String, power: u64, ctx: &mut TxContext) {
    //TODO: Create a Hero object
    let hero = Hero {
        id: object::new(ctx),
        name: name,
        image_url: image_url,
        //  struct icindeki variables name ile function icinde yer alan ad ayni ise sdece ismi yazmak yeterlidir.
        power,
    };

    //TODO: Transfer the Hero Object to the sender
    // example taransfer function: transfer::transfer(obj, recipient)
    transfer::transfer(hero, ctx.sender())

    // transfer::transfer_hero(hero, ctx.sender()); da transfer_hero tanimlandigi icin kullanilabilirdi
}

public entry fun transfer_hero(hero: Hero, to: address) {
    transfer::transfer(hero, to)
}

// ========= GETTER FUNCTIONS =========

#[test_only]
public fun hero_name(hero: &Hero): String { hero.name }

#[test_only]
public fun hero_power(hero: &Hero): u64 {
    hero.power
}

#[test_only]
public fun hero_image_url(hero: &Hero): String {
    hero.image_url
}
