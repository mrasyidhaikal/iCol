//
//  Challenges.swift
//  iCol
//
//  Created by Wendy Kurniawan on 18/10/20.
//

import Foundation

struct Challenges {
    static let challenges = [
        Challenge(
            name: "Eat Less Fried Foods",
            image: "Fried",
            description:
                """
                Hello, I'm here to help you eat less fried food. We'll proceed step by step, okay?

                First of all, I'll tell you a little bit story about fried food.

                1. Fried foods are high in fat, calories, and often salt.
                2. Fried foods are also linked with health problems and disease
                3. Fried foods don't offer nutrient

                I'm sorry to say all of these. We'll go through this together, okay?

                I'll help you. Let's set a plan, shall we?
                """,
            type: .decrease
        ),
        Challenge(
            name: "Eat More Vegetables",
            image: "Vegetable",
            description:
                """
                Hello, I'm here to help you eat more veges. Shall we start?

                So, here's the story of veges:

                1. Veges can lower the bad cholesterol in your body. Wow, isn't that good?
                2. Veges can also reduce the risk of heart diseases, heart attack, stroke, and hypertension.
                3. Most veges are low in fat and calories. So naturally, there's no cholesterol.

                I know you can do it! Trust me! So, shall we eat more veges together?

                Let's start !
                """,
            type: .increase
        ),
        Challenge(
            name: "Eat Less Fast Food",
            image: "Burger",
            description:
                """
                Hello, I'm here to help you eat less fast food. Shall we start?

                So, this is the reality about fast food

                1. Fast food are high in trans fat which can raise bad cholesterol level
                2. The worst scenario is it can raise the chance of having heart disease
                3. Fast foods can boost high cholesterol and high blood pressure

                Sadly, but this is the reality. But don't be afraid, i'm here for you.

                Let's set a plan, shall we?
                """,
            type: .decrease
        ),
        Challenge(
            name: "Drink Less Soda",
            image: "Soda",
            description:
                """
                Hello, I'm here to help you drink less soda. Shall we start?

                So, let me tell you somethings about soda

                1. Soda itself can raise triglycerides which results in stroke
                2. Soda can add extra chalories which add strain to heart
                3. Soda also lower the good cholesterol in your body

                If you drink too much, don't be afraid. We'll help you reduce it slowly, okay?

                Ready to set a new plan ?
                """,
            type: .decrease
        )
    ]
}
