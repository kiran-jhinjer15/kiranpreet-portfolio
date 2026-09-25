import 'package:flutter/material.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';

class ProductFlowStep {
  const ProductFlowStep({required this.label, required this.detail});

  final String label;
  final String detail;
}

class CaseStudyHighlight {
  const CaseStudyHighlight({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;
}

class CaseStudyChallenge {
  const CaseStudyChallenge({required this.challenge, required this.approach});

  final String challenge;
  final String approach;
}

class CaseStudyContent {
  const CaseStudyContent({
    required this.flow,
    required this.highlights,
    required this.challenges,
  });

  final List<ProductFlowStep> flow;
  final List<CaseStudyHighlight> highlights;
  final List<CaseStudyChallenge> challenges;
}

abstract final class CaseStudyData {
  static CaseStudyContent? forProject(ProjectData project) {
    return _byId[project.id];
  }

  static const Map<String, CaseStudyContent> _byId = {
    ProjectsData.viewghanaId: CaseStudyContent(
      flow: [
        ProductFlowStep(label: 'Discover', detail: 'Offers and experiences'),
        ProductFlowStep(
          label: 'Explore',
          detail: 'Restaurants, lounges, and cinemas',
        ),
        ProductFlowStep(
          label: 'View offer',
          detail: 'Offer-related functionality',
        ),
      ],
      highlights: [
        CaseStudyHighlight(
          icon: Icons.cloud_outlined,
          title: 'REST API integration',
          detail: 'Integrated REST APIs.',
        ),
        CaseStudyHighlight(
          icon: Icons.qr_code_2_outlined,
          title: 'QR integration',
          detail:
              'The ecosystem includes a vendor application for QR code scanning, offer validation, and vendor-side UI.',
        ),
        CaseStudyHighlight(
          icon: Icons.local_offer_outlined,
          title: 'Offer workflows',
          detail: 'Implemented offer-related functionality.',
        ),
      ],
      challenges: [
        CaseStudyChallenge(
          challenge: 'Offer information needs to reach user-facing screens.',
          approach: 'Integrated REST APIs and built user-facing workflows.',
        ),
        CaseStudyChallenge(
          challenge: 'Offer validation sits in the wider product ecosystem.',
          approach:
              'The ecosystem includes a vendor application for QR code scanning, offer validation, and vendor-side UI.',
        ),
      ],
    ),
    ProjectsData.bumperBudsId: CaseStudyContent(
      flow: [
        ProductFlowStep(label: 'View PDF', detail: 'PDF viewing'),
        ProductFlowStep(label: 'Place banner', detail: 'Banner placement'),
        ProductFlowStep(label: 'Purchase', detail: 'Banner placement purchase'),
      ],
      highlights: [
        CaseStudyHighlight(
          icon: Icons.picture_as_pdf_outlined,
          title: 'PDF viewing',
          detail: 'Implemented the PDF viewing experience.',
        ),
        CaseStudyHighlight(
          icon: Icons.dashboard_customize_outlined,
          title: 'Banner placement',
          detail: 'Implemented the banner placement workflow.',
        ),
        CaseStudyHighlight(
          icon: Icons.payments_outlined,
          title: 'Payment integration',
          detail: 'Integrated the Stripe payment gateway.',
        ),
      ],
      challenges: [
        CaseStudyChallenge(
          challenge: 'Users view a PDF and place a banner in the document.',
          approach:
              'Implemented the PDF viewing experience and banner placement workflow.',
        ),
        CaseStudyChallenge(
          challenge: 'Banner placements are purchased in the application.',
          approach:
              'Integrated the Stripe payment gateway and payment-related application workflows.',
        ),
      ],
    ),
    ProjectsData.daawatId: CaseStudyContent(
      flow: [
        ProductFlowStep(label: 'Explore', detail: 'Menu and services'),
        ProductFlowStep(label: 'Order', detail: 'Customer ordering'),
        ProductFlowStep(label: 'Rewards', detail: 'Rewards'),
        ProductFlowStep(label: 'Orders', detail: 'Order workflows'),
      ],
      highlights: [
        CaseStudyHighlight(
          icon: Icons.devices_outlined,
          title: 'Responsive UI',
          detail: 'Implemented responsive UI.',
        ),
        CaseStudyHighlight(
          icon: Icons.widgets_outlined,
          title: 'Reusable components',
          detail: 'Built reusable Flutter components.',
        ),
        CaseStudyHighlight(
          icon: Icons.cloud_outlined,
          title: 'REST API integration',
          detail: 'Integrated API-driven screens.',
        ),
        CaseStudyHighlight(
          icon: Icons.account_tree_outlined,
          title: 'State management',
          detail: 'Worked with state management.',
        ),
      ],
      challenges: [
        CaseStudyChallenge(
          challenge: 'Customer-facing screens run on Android, iOS, and web.',
          approach:
              'Implemented responsive UI and built reusable Flutter components.',
        ),
        CaseStudyChallenge(
          challenge: 'Screens are driven by application data.',
          approach:
              'Integrated API-driven screens and worked with state management.',
        ),
      ],
    ),
  };
}
