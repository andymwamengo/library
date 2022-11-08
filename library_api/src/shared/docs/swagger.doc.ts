import type { INestApplication } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

export function SwaggerDoc(app: INestApplication): void {
  const options = new DocumentBuilder()
    .addSecurity('Bearer', {
      type: 'http',
      scheme: 'Bearer',
    })
    .setTitle('Library')
    .setDescription('THE Library API Doc')
    .setVersion('1.0.0')
    .addTag('Library', 'The API documentation for the Library API')
    .build();

  const document = SwaggerModule.createDocument(app, options);
  SwaggerModule.setup('api/docs', app, document);
}
